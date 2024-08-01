Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4F16DC2F;
	Thu,  1 Aug 2024 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511926; cv=none; b=YRQD7K0upKN6uBVh4wBv6/eMsmVBq2g8GEXUS2s7NB4oYeY0BQl+4efUI6S06qJZfHN0jvS6aiLJYD3PaBzUB+DU/0RxXEnjKaBeiCdJ0rmxQL2+lJcScyudWXOiymOP71BDv1GFqu+3F8n9x161C31RDT0bQYaQew9ZkChSZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511926; c=relaxed/simple;
	bh=VDgbkzSy6pdn7BBt+7W3T6jN6xudBS9RtTDaoEzS1yQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOqsrIuQk0Li1pjOtC0BAIj+ef5C9jRYP6L8TK4FF4T+MBth9K/wexirGlsEVtbgDYIdjJiWvQoxB16snhcaHMkHeZ0phzia4zRoeU8kmmWAxuX9IiHYma0nK48XfX8xP/AI5kybMpAY4OAz9/rg88ACOTEQOldkpcJeCVtg4Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FA0O5HeL; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FA0O5HeL"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so3643538a12.0;
        Thu, 01 Aug 2024 04:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722511924; x=1723116724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwgt/ZE+D10zyyktrtFq6cZQwEQSNzuYzBpK2SkBtZ8=;
        b=FA0O5HeLnSNj93WM9KO+yIVYkkuAKygn88mb7gaUEydHvptLEsDotKypwcIVM1t9Cc
         QRsP1nLdyoVq2Tqh/9+UI3Lq/x4VeDRyAYVzLr8vVq5f0XZcdr3RAb+avX2das7Eo0IT
         7hgSMJQ53EMDhTjSVnwrt3Z4pEx4FluDLcwXZyBPcl76ZRrkdekwB436CjuKz3sLxqVE
         GTNphgxKpKylmU94qHL2L9BjneKoeYCZR23lzaJNcNF2VxCoJLkqhicw8ocU+4r8Up3U
         36ZmGRYaHoGvkB1MsaHWyA8cKQ+9UCcvxHZsSWkoHPxzbp3/fHc5rdKV+2d4AS1Te7Q4
         lUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722511924; x=1723116724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwgt/ZE+D10zyyktrtFq6cZQwEQSNzuYzBpK2SkBtZ8=;
        b=HS/MenCtiQvCuloozj0Hl0YoMBQWOHrSMzqePgS4tMX4g1m7Q0VEnOo6OLT5YidU2k
         B5F8bYy1XwAEhKtrxaOdaBb0RTwA0QSw59YYxosSGj//JeGRJ3A1B7+M/mF7CbiVhMk3
         HrhgBKaQ2iHKK7jDN3aAwPdkN7Xz+hRWgKyzIWyg5hXB9sZ89KI6mM2JJwMb+iQltH4z
         V/m1v3QMcPFeyF01pZ4vOlfMrP4NE6uytbmQhmWqzHKnUzd1Swl4Fr6Cby5sZHRxsxbk
         N+MItCs876qXwR3+hL5kQ60LpERWp3ggmIj2Jr7/4A4pF3MOSjiZXD8IPtuaDsHQsq0E
         adPw==
X-Forwarded-Encrypted: i=1; AJvYcCVxYiA4fQdG3Y7DjVRf2Ikn66H0WgTX3wdD564KKdGsCk7GvclnCNfkWmoKJ/hR5DMVfyWMOZdREEUhiKoLFvNi967h9pqof+rkLMNUmEDLa4FzN06Qi6Nh9j6ADwdWyCCnkiZYBAFuvnI+LM9ME9FS
X-Gm-Message-State: AOJu0YwhZn/Abw0x5srZZaEUXN01JmbQesTxU7Zm+PzrwNFjNjLbenl2
	CtFKaNGHDj7/OKbCicBc5GWNdx/Enfot1EoZhNzOg6OcV47stSjb
X-Google-Smtp-Source: AGHT+IGsA4jWSMwcA0vhxehDG6CkxNwbXoJAz1NwOzbIbMvlHmBQCYZwHqy2J3Kgg/H9/iu2yoo7rQ==
X-Received: by 2002:a17:907:3fa9:b0:a7a:bcbc:f7f4 with SMTP id a640c23a62f3a-a7dbcbe50bdmr100814266b.14.1722511923294;
        Thu, 01 Aug 2024 04:32:03 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad9d41esm883366766b.154.2024.08.01.04.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 04:32:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 1 Aug 2024 13:32:01 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org,
	peterz@infradead.org, rostedt@goodmis.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
Message-ID: <ZqtyMTyu3uneHZDJ@krava>
References: <20240729134444.GA12293@redhat.com>
 <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>

On Wed, Jul 31, 2024 at 09:18:00AM -0700, Andrii Nakryiko wrote:

SNIP

> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 5f152afdec2f..73a6b041bcce 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -431,6 +431,7 @@ uprobe_ret_handler(struct uprobe_consumer *self,
> unsigned long func,
>  }
> 
>  struct testmod_uprobe {
> +       struct uprobe *uprobe;
>         struct path path;
>         loff_t offset;
>         struct uprobe_consumer consumer;
> @@ -458,12 +459,14 @@ static int testmod_register_uprobe(loff_t offset)
>         if (err)
>                 goto out;
> 
> -       err = uprobe_register(d_real_inode(uprobe.path.dentry),
> -                             offset, 0, &uprobe.consumer);
> -       if (err)
> +       uprobe.uprobe = uprobe_register(d_real_inode(uprobe.path.dentry),
> +                                       offset, 0, &uprobe.consumer);
> +       if (IS_ERR(uprobe.uprobe)) {
>                 path_put(&uprobe.path);
> -       else
> +               uprobe.uprobe = NULL;
> +       } else {
>                 uprobe.offset = offset;
> +       }
> 
>  out:
>         mutex_unlock(&testmod_uprobe_mutex);
> @@ -474,10 +477,10 @@ static void testmod_unregister_uprobe(void)
>  {
>         mutex_lock(&testmod_uprobe_mutex);
> 
> -       if (uprobe.offset) {
> -               uprobe_unregister(d_real_inode(uprobe.path.dentry),
> -                                 uprobe.offset, &uprobe.consumer);
> +       if (uprobe.uprobe) {
> +               uprobe_unregister(uprobe.uprobe, &uprobe.consumer);
>                 uprobe.offset = 0;
> +               uprobe.uprobe = NULL;

ugh, I think we leak &uprobe.path.. I can send follow up fix if needed

jirka

>         }
> 
>         mutex_unlock(&testmod_uprobe_mutex);
> 
> 
> [...]
