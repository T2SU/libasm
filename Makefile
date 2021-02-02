# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/02 16:51:52 by smun              #+#    #+#              #
#    Updated: 2021/02/02 17:00:17 by smun             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC = gcc
CFLAGS = -Wall -Wextra -Werror
NASM = nasm
NFLAGS = -f macho64
AR = ar
AFLAGS = -rc

INC = -I./
LIB_DIR = -L./
LIB = -lasm
NAME = libasm.a
MAIN = main

M_DIR = ./

M = helloworld
M_SRC = $(addprefix $(M_DIR), $(addsuffix .s, $(M)))
OBJ = $(M_SRC:.s=.o)
MAIN_SRC = $(addsuffix .c, $(MAIN))
MOBJ = $(MAIN_SRC:.c=.o)

all : $(NAME)

$(NAME)		:	$(OBJ)
			$(AR) $(AFLAGS) $(NAME) $(OBJ)

$(MAIN)		:	$(MOBJ)
			$(CC) $(CFLAGS) $(INC) $(LIB_DIR) $(LIB) $(MOBJ) -o $(MAIN)

clean		:
			rm -rf $(OBJ)
			rm -rf $(MOBJ)

fclean		:	clean
			rm -rf $(NAME)
			rm -rf $(MAIN)

re			:	fclean all

%.o			:	%.c
			$(NASM) $(NFLAGS) $(INC) -s $< -o $@


