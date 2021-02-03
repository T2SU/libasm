# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: smun <smun@student.42seoul.kr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/02/02 16:51:52 by smun              #+#    #+#              #
#    Updated: 2021/02/03 15:35:57 by smun             ###   ########.fr        #
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
EXEC = read_write \
		strlen \
		strcpy \
		strcmp \
		strdup

M_DIR = ./mandatory/

M = ft_read \
	ft_write \
	ft_strlen \
	ft_strcpy \
	ft_strcmp \
	ft_strdup
M_SRC = $(addprefix $(M_DIR), $(addsuffix .s, $(M)))
OBJ = $(M_SRC:.s=.o)

all : $(NAME)

$(NAME)		:	$(OBJ)
			rm -rf $(NAME)
			$(AR) $(AFLAGS) $(NAME) $(OBJ)

$(EXEC)		:	$(NAME)
			$(CC) $(CFLAGS) $(INC) $(LIB_DIR) $(LIB) $(addsuffix .c, $@) -o $@

exec		:	$(EXEC)


clean		:
			rm -rf $(OBJ)

fclean		:	clean
			rm -rf $(NAME)
			rm -rf $(EXEC)

re			:	fclean all

rex			:	fclean exec

%.o			:	%.s
			$(NASM) $(NFLAGS) $(INC) -s $< -o $@
