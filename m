Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A1E17DA10;
	Tue,  2 Jul 2024 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964749; cv=none; b=YxiKL3upoT6soQfFxtkYk3J8kpn/vkmGw8bMtF/nOrsOcwPg62uM6ZxrPNu9kcI7AKW+tVs61fP9/hgKME9MsqHTmr+SrgtKl3R5Zm8KHQ78m8bo4fUlrknVzAh9Uj9Z5KnZULHiCaJ31+7GH6bj/NQ9i2yYgnRLEoOZPr8t4ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964749; c=relaxed/simple;
	bh=IPlgBXQ68q+S9gFXugDS4J7Apavl4Y4Wy55olmLhoSQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MOLtmET3gOBPl7pNGpXIMY3/Dq3pjiaSCTjCucHqw5b1o+oXNhzxX0yK3VeSB84qDGwNpwZZUZrXYTCejGO5R5H6VpQKJaoXr6S07hWAMdbaGbCP68OwmNEizSTpFG++1MAavUwwkkrVpn3zxaLw6VRxpWjIHrHX0UDSib7YdwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOiteaCq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOiteaCq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E530FC2BD10;
	Tue,  2 Jul 2024 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964749;
	bh=IPlgBXQ68q+S9gFXugDS4J7Apavl4Y4Wy55olmLhoSQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hOiteaCqEAkMcHUfIkQLTXFLJ4RaexdX/oJ2hpokdSXHRmb94I12ZQxtUsDZD1eBi
	 ZjaAIMGNeao/bGITuEsYg4j9FS7WatSmkMUnlzESJPiQ+Vcb3/Y26HZaZp8y8CI+zp
	 L9p7erzNF/sp/a6HLysCIse9BmgMR9N2mBH0lXgqK9u6C+po/Nu6FhrHvNCNnii3E9
	 9xlOSUhB6+mFlKKzjp9uWzVoZfaBe0SJgu0+WMfstHu/tIsEo8CppuEQbZRQCORZi8
	 Sc7qJxflvZFPZl4t+o1LrYZ/wyTUk5BIU9U6tDsLOcPhsWsXY6I5rul6UDbk7unPdM
	 qInHpbBFDAyzg==
Date: Wed, 3 Jul 2024 08:59:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Dmitry V. Levin" <ldv@strace.io>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] tracing: Have memmapped ring buffer use ioctl of "R"
 range 0x20-2F
Message-Id: <20240703085904.aad69ff3e56eb413de81a3c5@kernel.org>
In-Reply-To: <20240702153354.367861db@rorschach.local.home>
References: <20240702153354.367861db@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jul 2024 15:33:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> To prevent conflicts with other ioctl numbers to allow strace to have an
> idea of what is happening, add the rang of ioctls for the trace buffer
> mapping from _IO("T", 0x1) to the range of "R" 0x20 - 0x2F.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20240630105322.GA17573@altlinux.org/
> 
> Reported-by: "Dmitry V. Levin" <ldv@strace.io>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  Documentation/userspace-api/ioctl/ioctl-number.rst | 1 +
>  include/uapi/linux/trace_mmap.h                    | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a141e8e65c5d..9a97030c6c8d 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -186,6 +186,7 @@ Code  Seq#    Include File                                           Comments
>  'Q'   all    linux/soundcard.h
>  'R'   00-1F  linux/random.h                                          conflict!
>  'R'   01     linux/rfkill.h                                          conflict!
> +'R'   20-2F  linux/trace_mmap.h
>  'R'   C0-DF  net/bluetooth/rfcomm.h
>  'R'   E0     uapi/linux/fsl_mc.h
>  'S'   all    linux/cdrom.h                                           conflict!
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> index bd1066754220..c102ef35d11e 100644
> --- a/include/uapi/linux/trace_mmap.h
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -43,6 +43,6 @@ struct trace_buffer_meta {
>  	__u64	Reserved2;
>  };
>  
> -#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
> +#define TRACE_MMAP_IOCTL_GET_READER		_IO('R', 0x20)
>  
>  #endif /* _TRACE_MMAP_H_ */
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
