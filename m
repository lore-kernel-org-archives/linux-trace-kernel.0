Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12210364E9A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893630; cv=none; b=nXsVRbeA0OxfvOhka23seC7k6WhIi5/EXOwew1is7Q1nvJaD4qMBQpEXpKxObdcM0z2uTDNH/e2/MlminEucMINhFJpzowQPz33Hxp+rzdpL5ivw+bE2n/JVzl6avWV6JGmUpOCkS8BJRmD2Wy6fulHfXGo9uEXd5onfb+lWvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893630; c=relaxed/simple;
	bh=oo331MyVoc+k3UZL6I7kuvuEyuD++kbF4dU3KtoNNTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPSic9T2RyTZwZ87kmIPNRLIqoV8jGRgo9pq6U02AznEkLfuBBP3x0ehxFyRlYTgf7ZqovTsNXh3ombCvxEg7CGHb/6AhjoVMttzsVMuVk+ZUdCpCK4LbmgwAp3hziicwQBJxuLiJeABQXFDoOP24P93vZCdzSrGuW9v6vbTAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b8Y6ScLo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b8Y6ScLo"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb5810d39so2163020f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765893625; x=1766498425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KL96hyDg6qSdwafAtR/5W1zXZLQQAbfSahId8IWk8M0=;
        b=b8Y6ScLoX5CWuU5ef57/9McoGZWMx0ykOvsSKm4b7UvYiKdmD3CwN0uKerpIY9XF9/
         JQZH8ImxB4fww4Ho1kNeL0EVA4UBf9ACX6lvLBBtG8soFak/seqA5KwDYYbKmVEWRuZG
         o0fCJoS2x38q4b6miFoIJ7feIPURndgsaLkASOt1t0F4eb8KNs1chPWrZufgxv0hqinY
         bvlX2fJH6t764FCoHe7bD97P6O9okEz5MKjzBmnf4wwH0L0EqLKjShA+9yIGOkfqan8i
         ys57tB7dh1aSRWjOGzSeBl55LSE1Os4fwnexqjrcY7rPE8nYYV5ZUPwFlwYLfMgmC6oB
         SaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765893625; x=1766498425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KL96hyDg6qSdwafAtR/5W1zXZLQQAbfSahId8IWk8M0=;
        b=xFxRXe6VB3IrQzcJ5uCQL2AIPgTnA/MosyQiUbJuz+FjA4ozzA8HWugtfFnXm6WXVJ
         LjJL3tR/rISNOH0fd0LN8wTqx7DJ2ZdTwxYsBD+6yG2fwSpdY1YGIN6Sy9ow/E0lIjk9
         TGSwbWEod3STcZu0r0tNwlMzvaHtSDjaBvYUZe1rB2vhASUar96kSCUkix7WvJWyNLsk
         bvqcunG26vXjkHGfVh9zbJ9YK7Fr7mvuYoLYjAauaVQrtllrRjcYaxryWkktQb27VkUp
         h2Z8rcjjoeORMIG2l0wnvBgNPAyROYYV46onySHzgRdsx7pMc+/iBAo3/AwXJzsRMbFh
         YNDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV1z2LLhgnS/HrenrKGB+SfaWkCyNSw4YSs0OUfqoHlLUqklJOjB++Wtc18KVc4vJXb82AM9/DrQML8jgQzNsVV60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWvg5YcE9kUm5h6cuyt/+pK2YoGafQtbfE2MU4QTbZ+iJ/HcJm
	yl2hagg6+dnXNWCsOe1Z3bF+E53lquXhefSaeDcXcZnyBq5IP3ZnPBFhIShXtIZPzOE=
X-Gm-Gg: AY/fxX5mXvOWGzYwF37v6GWhcYDrFMs76xlxL1wquM1WZkPRTq3L8fu6923ZOxehfD2
	05FHyLKJn0nSwZ2ggH3Kcccn3BQyjcoybAxGbgyLf4WX+NMqBmyFJMZR8cccgrIwxzXmKJhEhhp
	uFA7+mkEaGZ2LjwYCXGgKONkqMta3kg3xgbwruaPAkqSeBefGVg9PpomdqxuSH/iay3qiO7xmBE
	U4pd2Vk5PxRw6v+P73UbqQTSscvwrWrtp/DNuItHriQHFx97CKdx1kV0UhoFKNCllvXuhAoP8us
	mcZzmhWvXCMenTKvTPJchVFVoSzAmAcj2O8X24BrCF3UJ0NaWLP2YqQ9rshnDSyYTJJGP/zPurq
	labkArUKJDl6hMPf3YR+Ehmd15p066jNiTLVqLsr66iaPfpX8FvaXQvM36ih+hci+1whQfCS0M2
	ECWsmTVsFbsz4xtg==
X-Google-Smtp-Source: AGHT+IEvNNp/GFZ2IQ7L7fWWzVzKQJ39p1H+1gouoPgfCo05L1mXn72S5xo0BtukHnsmhWUV5hIWfw==
X-Received: by 2002:a05:6000:2585:b0:431:8bf:f07c with SMTP id ffacd0b85a97d-43108bff231mr1464493f8f.9.1765893625280;
        Tue, 16 Dec 2025 06:00:25 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43009dfe5b3sm24065754f8f.39.2025.12.16.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 06:00:24 -0800 (PST)
Date: Tue, 16 Dec 2025 15:00:22 +0100
From: Petr Mladek <pmladek@suse.com>
To: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] kallsyms: Prevent invalid access when showing
 module buildid
Message-ID: <aUFl9n3b8DWnYGyJ@pathway.suse.cz>
References: <20251128135920.217303-1-pmladek@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128135920.217303-1-pmladek@suse.com>

Hi,

I wonder who could take this patchset.

IMHO, the failed test report is bogus. The system went out of memory.
Anyway, the info provided by the mail is not enough for debugging.

IMHO. this patchset is ready for linux-next. Unfortunately, kallsyms
do not have any dedicated maintainer. I though about Kees (hardening)
or Andrew (core stuff). Or I could take it via printk tree.

Best Regards,
Petr

On Fri 2025-11-28 14:59:13, Petr Mladek wrote:
> This patchset is cleaning up kallsyms code related to module buildid.
> It is fixing an invalid access when printing backtraces, see [v1] for
> more details:
> 
>   + 1st..4th patches are preparatory.
> 
>   + 5th and 6th patches are fixing bpf and ftrace related APIs.
> 
>   + 7th patch prevents a potential race.
> 
> 
> Changes against [v2]:
> 
>   + Fixed typos in commit message [Alexei]
> 
>   + Added Acks [Alexei]
> 
> 
> Changes against [v1]:
> 
>   + Added existing Reviewed-by tags.
> 
>   + Shuffled patches to update the kallsyms_lookup_buildid() initialization
>     code 1st.
> 
>   + Initialized also *modname and *modbuildid in kallsyms_lookup_buildid().
> 
>   + Renamed __bpf_address_lookup() to bpf_address_lookup() and used it
>     in kallsyms_lookup_buildid(). Did this instead of passing @modbuildid
>     parameter just to clear it.
> 
> 
> [v1] https://lore.kernel.org/r/20251105142319.1139183-1-pmladek@suse.com
> [v2] https://lore.kernel.org/r/20251112142003.182062-1-pmladek@suse.com
> 
> 
> Petr Mladek (7):
>   kallsyms: Clean up @namebuf initialization in
>     kallsyms_lookup_buildid()
>   kallsyms: Clean up modname and modbuildid initialization in
>     kallsyms_lookup_buildid()
>   module: Add helper function for reading module_buildid()
>   kallsyms: Cleanup code for appending the module buildid
>   kallsyms/bpf: Rename __bpf_address_lookup() to bpf_address_lookup()
>   kallsyms/ftrace: Set module buildid in ftrace_mod_address_lookup()
>   kallsyms: Prevent module removal when printing module name and buildid
> 
>  arch/arm64/net/bpf_jit_comp.c   |  2 +-
>  arch/powerpc/net/bpf_jit_comp.c |  2 +-
>  include/linux/filter.h          | 26 ++----------
>  include/linux/ftrace.h          |  6 ++-
>  include/linux/module.h          |  9 ++++
>  kernel/bpf/core.c               |  4 +-
>  kernel/kallsyms.c               | 73 ++++++++++++++++++++++++---------
>  kernel/module/kallsyms.c        |  9 +---
>  kernel/trace/ftrace.c           |  5 ++-
>  9 files changed, 81 insertions(+), 55 deletions(-)
> 
> -- 
> 2.52.0
