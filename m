Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038516;
	b=fsof+RLWjDYntKBY5q0fBMK3utub4SR3ZYmLGJOjSGLt49Q+guwFM8Fmmt471ru8TpYP
	 w7JdZqmHfPVl0QlFJpgQX+1VlPv0qlYu6f1IAwHSSxSRDfXRVxiXI1zmRSxYZdhqb7JBj
	 Dw11R+4eYyG44ywHxcgNTMsFQGtddwoXiXzgnKd0aT0sxzCTOODoyH+9L7Lw5xIBvgebk
	 vmk1sHc66x+7u8Fx5MuZWGltTDpuEKrMsnPqVWqRARUf77zpI4iPhmIW7mISn+seL8NcQ
	 3iCMkIOHOJenOMsXRPnlCnvBUDq7zEOLqE62yWFqy8wla15qrhwvV5TQavCQdQmx/kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038516;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=VqVAtNQ8v7CkSPLnfOhS9v4cAxVlBrZl/SJZ5NKGLRk=;
	b=bckV8q/9QkU9WSSzIexOyDZHFevukabMAVe3jy2rqCllblZmkm/m2nX8hcyb2sJBS/p7
	 5Sg6Xg4gX/mD540cVVyQVg9mAFGq7NUMJ4Jz5HaocQDG0vXOYDoSp+Cjzu71APYouD0Eq
	 7OTKVbkBtO48ZGZepDbqE34ipvpzkaGCtSDnuPhRPkZIn9p1tiY/Sjfux+2br3vJXghtG
	 bh3HAgrNff2UcaLqksFBoFGHroDzVUiVGu2+KyTmVXHPOojlXY2Mp+1NYyML/0I6tCLqz
	 6LGhehgu/SIaaIMOdKYB2GHY0LRa8a7m65nk2TmJSABEmK5llUNek2UTQsYn14WesGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Y86y+Dyl;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AC6606A31C;
	Wed, 18 Nov 2026 21:48:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64AC6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Y86y+Dyl
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9AA2C20B7169;
	Wed, 18 Nov 2026 13:48:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AA2C20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795038514;
	bh=VqVAtNQ8v7CkSPLnfOhS9v4cAxVlBrZl/SJZ5NKGLRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y86y+DylqjJhbT7yOyILhAHphvHvsea5DzlB3SdDIlMIqr/JFAkLUS+7Rwp0Zx1ZC
	 nsKBoaxSEy+1Rbym68BCzXqb2GCRp66JUnuazlQ38yLylUNBBx5wkEOgRXLxgFFfbr
	 zhamMqMpSYqUhYvk6HTAfx6YVLAzyqo14MJw6xvo=
Date: Wed, 18 Nov 2026 21:48:27 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Do not allow user events to add a system name
Message-ID: <20261118214827.GA683-beaub@linux.microsoft.com>
References: <20261118122520.4a689710@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118122520.4a689710@gandalf.local.home>

On Wed, Nov 18, 2026 at 12:25:20PM -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> User events currently do not support the addition of a system name, but
> the parsing does not check to see if one is specified.
> 
> A kprobe can add its own system name with the following command:
> 
>  ~# echo 'p:mysystem/kprobe_event schedule a=%ax' >> dynamic_events
>  ~# ls events/mysystem
>  enable  filter  kprobe_event
> 
> But if one tries to do the same with user events:
> 
>  ~# echo 'u:user_events/test u32 a' >> dynamic_events
>  ~# ls events/user_events
>  ls: reading directory 'events/user_events/': Invalid argument
>  enable  filter
> 
> It corrupts the file system as the event added had a '/' in the name.
> 
> Until user events support specifying system names, just return -EINVAL to
> prevent the corrupted file system from happening:
> 
>  ~# echo 'u:user_events/test u32 a' >> dynamic_events
>  -bash: echo: write error: Invalid argument
> 
> Cc: stable@vger.kernel.org
> Fixes: 7f5a08c79df35 ("user_events: Add minimal support for trace_event into ftrace")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_user.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index f658c3a77aa7..5d41a28e4493 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1035,6 +1035,9 @@ static int user_event_parse_cmd(struct user_event_group *group,
>  	if (flags)
>  		*flags++ = '\0';
>  
> +	if (strstr(name, "/") != NULL)
> +		return -EINVAL;
> +
>  	return user_event_parse(group, name, args, flags, newuser, reg_flags);
>  }
>  

Thanks Steve!

Acked-by: Beau Belgrave <beaub@linux.microsoft.com>

-Beau

> -- 
> 2.53.0
