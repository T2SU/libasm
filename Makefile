# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/02 16:51:52 by smun              #+#    #+#              #
#    Updated: 2021/02/04 02:58:37 by smun             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = gcc
CFLAGS = -Wall -Wextra -Werror -g -fsanitize=address
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
B = ft_atoi_base
B_SRC = $(M_SRC) $(addprefix $(B_DIR), $(addsuffix _bonus.s, $(B)))
BOBJ = $(B_SRC:.s=.o)

all : $(NAME)

$(NAME)		:	$(OBJ)
			rm -rf $(NAME)
			$(AR) $(AFLAGS) $(NAME) $(OBJ)

bonus		:	$(BOBJ)
			rm -rf $(NAME)
			$(AR) $(AFLAGS) $(NAME) $(BOBJ)

main		:	$(NAME) main.o
			$(CC) $(CFLAGS) $(LIB_DIR) $(LIB) main.o -o main

mainb		:	bonus mainb.o ft_atoi_base.o
			$(CC) $(CFLAGS) $(LIB_DIR) $(LIB) mainb.o ft_atoi_base.o -o mainb

clean		:
			rm -rf $(OBJ)

fclean		:	clean
			rm -rf $(NAME)
			rm -rf main mainb

re			:	fclean all

rem			:	fclean $(EXEC)

%.o			:	%.s
			$(NASM) $(NFLAGS) $(INC) -s $< -o $@

%.o			:	%.c
			$(CC) $(CFLAGS) $(INC) -c $< -o $@
