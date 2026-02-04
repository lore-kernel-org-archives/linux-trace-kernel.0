Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6B49620
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165238; cv=pass; b=efjo4Jr+DUBdc+jGerNdgCEl/ZmhF/Bp2ufWTGde6iTUlmefGoPe1G0brjf+DfagqlOu+zSaM+/SfslMdv4SIh0qZXcFnhcNJdx7VYLIhAHXVLmy+lJZU+bjHPRCLKNZYiVTCyu8cloupWo1+5TwgYjQ9DdjGqvXZRMBsHjcLsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165238; c=relaxed/simple;
	bh=BGYBSwLSXw3GozsSaycEkBwr/A0rvU61Cqbob+qm6+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MP3v4zZtq7uNLKgDwoRoPFTvu9Ud+jSW8EqhvK2SGQLh3hlIiLWzmRSMbJKEROayaZJrScQIEa2CJxuaybXyuh038FCDKY7AEwBWZ1DIK4BAEFBkYCWX+UZDKLcJMhR2R1/JQuE6NEMMylSJq9DE7Cn2BoWawR73sfNVF7QWXew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjxGUmMV; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjxGUmMV"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so47544545e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Feb 2026 16:33:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770165235; cv=none;
        d=google.com; s=arc-20240605;
        b=PyHDTNQZ4sGjQooEk590aoACIB+JPVVg28/BzrcxVVDyGaszMEuXTNba4Hb+JDlbP6
         BKC/L54LfEOWzzDJLALvH7W4UYjsst2bNQMq2nyFNv7J7aiQjDpzstDOON/HNxdOOz3z
         0mPMvtD18ZyvNY+vkA/gUZMwVF97HhdeiMLv8LDrIh61hrrwhv8+t+MqGSEuNOr0JUaJ
         uUbBko/oK28Ty30gvVIWN4j9TT9uQgAwMJsclXcisxF37d3OrqhItCjTe5VALSBqol+d
         +LY7ihq1pllZhI/tFmkVMV6iL63NqPGZGv7XrRAlioFGHjN/1vK9goNbQj36L2Dm1SqR
         4vSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SPVaxMJSX4AG/CeVmMqvFPaGAwqC64TXT71T62h0CPs=;
        fh=SxJeJThJANrlKFfvcg7CEHtkZ4LHficDceDC0ydS6SU=;
        b=OV8UyySsLR7rZrwkExhcbe2y5jA/caJzGv4/r/oKzfOUBOEE3s3DjeqKtVQkADXcf0
         p3z+wn/0UGaUHGtEGPWbTxlEj0/sIBGiGG1M/aIV8Eq8HyeIX49AXU+MbctfDmdYSs33
         AJov8ROPJ90G0HdqyC23fDMxTokR83hKwZUWtn8nusjG2n7lA+bRz+Zb/zKB1TziYYQy
         segePqMvnaY7v0KBZdbzCwt/vsoPH/QI7Pm7kC4NyiuG7RZgGGUCgMRFOdhbSoGwgt3V
         uo06wMbDvAR2vJTcdsS+VHrc1fGDjPoLsdtz+u+yuKQKGSvzPi5lyJ0Gj8bSSWWIa920
         AT5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770165235; x=1770770035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPVaxMJSX4AG/CeVmMqvFPaGAwqC64TXT71T62h0CPs=;
        b=YjxGUmMVEp2tVQqqVOigEEv1KH2gL2jCI1gSnxN+mwhAUVT95y/j8rNPQzsV9XM+je
         46uXbatWCmha0/6JRP5i2k2BDu+/+G2jlivmiJ5QHrNrMZGtKhecTueRit9NVwRk2oXC
         /+rRNTb8D9vybS5Q72W97RwD7/pd+Vk4gyVE6j1ApfXnnkMkwW65MxJBAr0V5R+jlM7K
         +yUV+B+uVyJcYBiNrigDZYxe76y3aPuC0nHMJ27701+R9hS5UIfi8sIKvCvYmizqwwJQ
         6Ue45HiBFsRaYOxxNpSN7vnN4uHdIi66jMbkfkbafmfC28UA62IvCKlr7jQvyyuZjK/L
         +Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165235; x=1770770035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SPVaxMJSX4AG/CeVmMqvFPaGAwqC64TXT71T62h0CPs=;
        b=FJ/myfFz8bjJkQmz3YYblW7zZHkAlD/4UwQ07aEnntqU2J+Vd2xbzMleub1nCJJhSA
         IqItTMrTU8zzEsP0YKypTd/XhDgElrvcq1OS2v7wNr2L2L8ODiPzL0c7RKEWPU/+WOkg
         jjkdgAUHyn+6LuDQ7mtNgJCWUL2ylnJSCQb7twsvp0L8nKi3Cwf8qxi3ZUZEpFIbOfIr
         F/LubBxy2vlpm3lzyx4QehUwqtEpsCOE+dhm4/HUIMtwdxV9SlpEIfCMo6odZCp+SxAP
         u3O6JwnevFRP6pYrOGssP95etfEVNfiLwnbHidUxZBCjtLFjEf5sfUPZTyRMGN5q8pv6
         T7Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXlVi4urwuFFkEeMrbVmjtuAy+ubWse4PPZhbU5xUvcQ21F7Aj83x9MSz70WXX+mPK1EFRejbqZbCacIJsNpnrLSHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLM605Kwz5CZoUB5rAssOkyjETyWw+rjj2AL2hSWhI/f99ffZ
	slS7aYlKaOPY3VO2mB3W7Lh3Ii4IXhoJ77HRz6Fcqus2tW9BtrG8MvCZbWQgSDzorXDBszVDRQq
	0XxX1O9wXjEq/lGwtlxsGR/7s/xu41Dk=
X-Gm-Gg: AZuq6aI3Yor+CGcCpmeX1ZQU7se4xeQKf/jDSrQwUyYEJL9F2S7xbomBaST+3WNZ3/o
	5kjBjldFX+mfznz3VrtM/cS+N4kiof1mOSnM95cs5ykh+tGdqTkHqMEHKN9IwIhrpRxFRqe7uRS
	N0COCVkf3t5GOoEGiMmmU06Ob++FPBoWeuQLFUFZ4ltAWJfPcvXr2Onmlhqp0R2isFQ808kFjIg
	qMTbKKF/2TiAxPyo/NcJshlSL4OhHGmA3xafYC1dW4Q7BWyh6FgSvCkC59Ov6ablYqcArwKqMlU
	G9z0GNmUeWOXEwMnJ9gvSvVdzsT1IyLpIOAg5PtygfyWX2LY7Tngddq6Bdc9OygEjyV/SXaqwMG
	2ChIGovJqJ6Qszw==
X-Received: by 2002:a05:6000:1a87:b0:435:9d70:f2a2 with SMTP id
 ffacd0b85a97d-43617e3ff2bmr1687108f8f.25.1770165234840; Tue, 03 Feb 2026
 16:33:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203162746.2337002-1-arnd@kernel.org> <CAADnVQ+14yum8okMmjuqF5m5DafWo1fY1EuPj-QU_ykYbQ01uw@mail.gmail.com>
 <5f9c89fe-df1d-4eb4-b724-08f8d90fcc59@app.fastmail.com> <CAADnVQKn4xP9s_koBuP7D_eqUX0dSPwUr-dOj3mTZNTh_VxqKQ@mail.gmail.com>
 <ab709a00-3a7f-423f-9d8b-b2cd17fef76f@app.fastmail.com> <CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com>
 <0d5b64a5-8cf9-45c7-8848-ac62d3fdca44@app.fastmail.com>
In-Reply-To: <0d5b64a5-8cf9-45c7-8848-ac62d3fdca44@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 16:33:43 -0800
X-Gm-Features: AZwV_Qjc7I4LW10A_MsBK9gzCnlcGrYFPLQJ4MHmI9YKwGlTTtcByDbp2yg08qk
Message-ID: <CAADnVQ+_Ed8HgtwF5UcX2Ee2SeHU6ad31Z01Zq=2uL2qpUmgsA@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing __printf attributes
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 3:21=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 3, 2026, at 19:11, Alexei Starovoitov wrote:
> > On Tue, Feb 3, 2026 at 9:44=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >> On Tue, Feb 3, 2026, at 18:24, Alexei Starovoitov wrote:
> >> I also see the comment about bstr_printf() mention that it
> >> uses a vsnprintf() compatible format, which would indicate that
> >> marking the format argument isn't wrong, though I agree it is
> >> not actually useful if there are no callers that pass a string
> >> literal.
> >
> > In general I don't think it's a good idea to add nop annotations
> > just to shut up over eager compiler warning.
>
> I've tried removing these three below, which now gives me
> a clean build with -Wsuggest-attribute=3Dformat, after the
> other three patches I posted for unrelated code.

Nice. lgtm. Ack.

>      Arnd
>
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index d6ebf0596510..2fb266ea69fa 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -181,7 +181,6 @@ int seq_open_private(struct file *, const struct seq_=
operations *, int);
>  int seq_release_private(struct inode *, struct file *);
>
>  #ifdef CONFIG_BINARY_PRINTF
> -__printf(2, 0)
>  void seq_bprintf(struct seq_file *m, const char *f, const u32 *binary);
>  #endif
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 1b564c36d721..b850bd91b3d8 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -336,8 +336,8 @@ int __sysfs_match_string(const char * const *array, s=
ize_t n, const char *s);
>  #define sysfs_match_string(_a, _s) __sysfs_match_string(_a, ARRAY_SIZE(_=
a), _s)
>
>  #ifdef CONFIG_BINARY_PRINTF
> -__printf(3, 0) int vbin_printf(u32 *bin_buf, size_t size, const char *fm=
t, va_list args);
> -__printf(3, 0) int bstr_printf(char *buf, size_t size, const char *fmt, =
const u32 *bin_buf);
> +int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args=
);
> +int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_=
buf);
>  #endif
>
>  extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *p=
pos,
