Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F224149C42;
	Mon,  6 Jan 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184040; cv=none; b=fiDpnp/kCvwu9j7XUeY/JTJH83rmJ4DbL7AFUuLbBk4iPaFf1pXZfGhNaKhWl4pM9C8pSi6LZI96tHdAzOJzeKuUufiQ711T9IstiPGNFHUu9JgF0vwF7N8bi41baqCKVzrQz9jBGMAoQ8rpLX+NXpd9Z5g/JgfC5/FsyQODKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184040; c=relaxed/simple;
	bh=orK1ptvj63ibYMww9iHrecyCimzBb18plduPm91QUPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byEN0pm+4oD9rkHKD/b36DDdraHwvpn5gk+8mSDDs11uqSZblAL6RA2MtQ8IhHyrz83szNFqfw6KZU0qTpQA5Hznm7MRgYB++gqfaCyRaaXpIJjBc73nUnkwBprYMYhgf+HeG5616od/+frnrj88fMD9xE6KI8Kkzl6Lzb+HpaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E28C4CEDF;
	Mon,  6 Jan 2025 17:20:38 +0000 (UTC)
Date: Mon, 6 Jan 2025 12:22:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: <shiju.jose@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>
Subject: Re: [PATCH 1/1] tracing: Support reading trace event format file
 larger than PAGE_SIZE
Message-ID: <20250106122204.0f16cb58@gandalf.local.home>
In-Reply-To: <20250102174317.1594-1-shiju.jose@huawei.com>
References: <20250102174317.1594-1-shiju.jose@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 17:43:17 +0000
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> When userspace reads a trace event format file, the maximum data size
> that can be read is limited to PAGE_SIZE by the seq_read() and
> seq_read_iter() functions. This results in userspace receiving partial
> data if the format file is larger than PAGE_SIZE, requiring a workaround
> to read the complete data from the format file.
> 
> Add support for reading trace event format files larger than PAGE_SIZE when
> needed by userspace.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

How is this an issue? This is common for all pseudo files and can be
handled properly from user space.

Here, with this program:

read.c:
-------------------------8<-------------------------
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/types.h>

int main (int argc, char **argv)
{
	char *buf;
	int fd;
	off_t size;
	int r, s;

	if (argc < 2) {
		printf("usage: %s file\n", argv[0]);
		exit(-1);
	}

	fd = open(argv[1], O_RDONLY);
	if (fd < 0) {
		perror(argv[1]);
		exit(-1);
	}

	size = BUFSIZ * 10;

	buf = malloc(size);
	for (s = 0, r = 1; r > 0; s += r) {
		r = read(fd, buf, size);
		if (r < 0) {
			perror(argv[1]);
			exit(-1);
		}
		printf("Read %d bytes from %s\n", r, argv[1]);
	}
	free(buf);
	close(fd);
	return 0;
}
------------------------->8-------------------------

 $ read /proc/kallsyms
Read 4091 bytes from /proc/kallsyms
Read 4075 bytes from /proc/kallsyms
Read 4078 bytes from /proc/kallsyms
Read 4083 bytes from /proc/kallsyms
Read 4093 bytes from /proc/kallsyms
Read 4076 bytes from /proc/kallsyms
Read 4080 bytes from /proc/kallsyms
Read 4086 bytes from /proc/kallsyms
Read 4080 bytes from /proc/kallsyms
Read 4064 bytes from /proc/kallsyms
Read 4071 bytes from /proc/kallsyms
Read 4063 bytes from /proc/kallsyms
Read 4069 bytes from /proc/kallsyms
Read 4079 bytes from /proc/kallsyms
Read 4063 bytes from /proc/kallsyms
Read 4072 bytes from /proc/kallsyms
Read 4046 bytes from /proc/kallsyms
Read 4091 bytes from /proc/kallsyms
Read 4090 bytes from /proc/kallsyms
Read 4067 bytes from /proc/kallsyms
Read 4080 bytes from /proc/kallsyms
Read 4066 bytes from /proc/kallsyms
Read 4085 bytes from /proc/kallsyms
Read 4095 bytes from /proc/kallsyms
Read 4076 bytes from /proc/kallsyms
Read 4090 bytes from /proc/kallsyms
Read 4066 bytes from /proc/kallsyms
Read 4073 bytes from /proc/kallsyms
Read 4091 bytes from /proc/kallsyms
Read 4075 bytes from /proc/kallsyms
Read 4076 bytes from /proc/kallsyms
Read 4048 bytes from /proc/kallsyms
Read 4074 bytes from /proc/kallsyms
Read 4058 bytes from /proc/kallsyms
Read 4074 bytes from /proc/kallsyms
[..]
Read 4052 bytes from /proc/kallsyms
Read 4061 bytes from /proc/kallsyms
Read 4061 bytes from /proc/kallsyms
Read 4053 bytes from /proc/kallsyms
Read 4083 bytes from /proc/kallsyms
Read 4066 bytes from /proc/kallsyms
Read 4093 bytes from /proc/kallsyms
Read 4072 bytes from /proc/kallsyms
Read 1982 bytes from /proc/kallsyms
Read 0 bytes from /proc/kallsyms

You see, it requires multiple reads to pull in an entire kernel pseudo
file. None of those reads are greater than PAGE_SIZE. Why should trace
format files be any different?

libtracefs handles this perfectly fine:

  https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/tree/src/tracefs-utils.c#n343

Looks like you are trying to change the kernel to fix a user space bug :-/

 NAK!

-- Steve
