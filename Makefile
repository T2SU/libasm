# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/02 16:51:52 by smun              #+#    #+#              #
#    Updated: 2021/02/05 17:11:29 by smun             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = gcc
CFLAGS = -Wall -Wextra -Werror -g
#CFLAGS = -Wall -Wextra -Werror -g -fsanitize=address -D ASAN=1
NASM = nasm
NFLAGS = -f macho64
AR = ar
AFLAGS = -rc

INC = -I./
LIB_DIR = -L./
LIB = -lasm
NAME = libasm.a

M_DIR = ./mandatory/
M = ft_read \
	ft_write \
	ft_strlen \
	ft_strcpy \
	ft_strcmp \
	ft_strdup
M_SRC = $(addprefix $(M_DIR), $(addsuffix .s, $(M)))
OBJ = $(M_SRC:.s=.o)

B_DIR = ./bonus/
B = ft_atoi_base \
	ft_list_remove_if \
	ft_list_push_front \
	ft_list_size \
	ft_list_sort
B_SRC = $(M_SRC) $(addprefix $(B_DIR), $(addsuffix _bonus.s, $(B)))
BOBJ = $(B_SRC:.s=.o)

MAIN_SRC = main.c
MAIN_OBJ = $(MAIN_SRC:.c=.o)
MAINB_SRC = main_bonus.c
MAINB_OBJ = $(MAINB_SRC:.c=.o)

all : $(NAME)

$(NAME)		:	$(OBJ) dellib
			$(AR) $(AFLAGS) $(NAME) $(OBJ)

bonus		:	$(BOBJ) dellib
			$(AR) $(AFLAGS) $(NAME) $(BOBJ)

main		:	$(NAME) $(MAIN_OBJ)
			$(CC) $(CFLAGS) $(LIB_DIR) $(LIB) $(MAIN_OBJ) -o $@

mainb		:	bonus $(MAINB_OBJ)
			$(CC) $(CFLAGS) $(LIB_DIR) $(LIB) $(MAINB_OBJ) -o $@

dellib		:
			rm -rf $(NAME)

clean		:
			rm -rf $(OBJ)
			rm -rf $(BOBJ)

fclean		:	clean dellib
			rm -rf main mainb

re			:	fclean all

rem			:	fclean main

remb		:	fclean mainb

%.o			:	%.s
			$(NASM) $(NFLAGS) $(INC) -s $< -o $@

%.o			:	%.c
			$(CC) $(CFLAGS) $(INC) -c $< -o $@
