Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC54244687
	for <linux-trace-kernel@vger.kernel.org>; Sun,  4 Oct 2026 03:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791083222; cv=none; b=givPf5/0VFcnEiMcMyxpHe1iVM4M5/SxCo0UHS+0uITZkZvOmCswYYW9Cvny0ph4dTx5W5C/WLQPRTu6h+cZkkn6NiUaKEgxC9HckNiU4JRKf4eb/s3xmyVZB1V0rCitwweSBZQQfmqe19Di8aDTNV3266Qcd6OYKaAeHgU0RD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791083222; c=relaxed/simple;
	bh=97w+wyZ4hAu1HtKz96oDWN8wbNGmXiBGOXZd1CtEwPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqv/y98h/0FJRyhRqZUjedyR/GW5evCbFT0k4mNi0X6A91S/XJr6MrVBg88LZX8fc22WSD2Bz8c+jY1fHnfFu5HzHUOXotda2HXputXWVmQD0JnGBr8OKGgPHWqGGgDOdvuS19lV8yVzO8zPUSLiZYpdkWLGuGgHd9KUImKvqow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esNvopqe; arc=none smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esNvopqe"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4e47db1adb8so221523b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Oct 2026 20:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791083219; x=1791688019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xGDw689I2nieuspdwl4thgn6puX+R1JqxzAeq5vzaqg=;
        b=esNvopqei4cqufxFq8JI2el58SZvD8t6JtDv3CgX9XCIdPziR/jTqzVNGsJBgpK8zq
         zdflu6iP/vs8UlIDCR4ITTBrT/bVmkN5X2l8BHATrnAhdvvD7Q/iiVIn+vy7BPDubaeI
         GMj6R6tjlOOCZTRhnwJengbA1Zf/a5QpaWD8qRnFwWswurAZiabhlmOa+Je49muMSf7f
         kVBvQxWjNdTNbrd6957UzSOyGApM+nK7443xC+D7dmYPp1xbjlLlmmtoBZD2IWUJnyTA
         IAc93ssF/R3+mH+YOIPsFAqgnBQH2P2cG/i+udAlIcwJfjxhi4BJyM6UCaOaMa+3O3jn
         KFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791083219; x=1791688019;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xGDw689I2nieuspdwl4thgn6puX+R1JqxzAeq5vzaqg=;
        b=YcG8Rq/1kvedZ3Ulrk6DKNjTPmfUhSJPU2ShXbBOh8oK+ahmFEff4TpKoOFnGRFhWC
         jy4Tw55VmZQIU7qJkJglbNg3emnQng5LjnYh9dcgLmuir1cOaUyejlgI9ifzb8Trr2+e
         PCJqfoyK/PjKtaqAcj5NAw4GLP1I6+cgQ1PizRSePVR1yXh3Hs1HFO7WZBTp0ER1w5fk
         DGt1NwfadTY0JpgED1nqYbq6tQKn0B663S/ZApl4eokh+r6IIWOzFcLLBOniKneS2Ojq
         aOaWbApOqjNSZsZkYNGDFJSg+WLBLLXYs1Zw0zwD5jxH7ZfOGZmCT6TExhBZ5uFH6WiX
         rx1A==
X-Forwarded-Encrypted: i=1; AKwUvBx2Y7BpZI87jes9+iC3v1gEbPDmJGDtpKxG4kdMqoRfyEoO4wyYdCgZ5JfWk8xym4auVEILWLb50qonzHM7nyzDBUs=@vger.kernel.org
X-Gm-Message-State: AFuF++lI2oFwrhJcoRJy1YIPIlEiegqKWbKq3nKw9kEW7LctSFCfYVRW
	XCv7I8bF9VHCLMkxI/hJVzsejXya+ygLIe0GFWscgw/n11r42NmmuQlq
X-Gm-Gg: AYBFou2LNS9YIEpyIrkaT8M9vviVLO6ajhIHCjsQXowlH38EtBb4eUWLaba0Bxok1Mi
	fmqBEnOnmVvpCg9LACXrEL0lAwrwnaVhZbPfQTUeksyZmMxE0Dgz5cGpJmTntF7RI/Bhvd1Q1I6
	xFyJCiqDXRYa05xXYnUmtc1joFiw5DSNKMdic+hKHDOoJ3QekPpLXZjiYvwI/bJVhwrKsSrF13v
	vmlNzC/QbtkSTiPueOEPAS7qSFN0Zb/9HtIaRE8OWZfG0Rg3cLoZ/fRqyWDTX3V+hLVvdPkKvGS
	jL7oj2t3jxETgOo803++O+6CXx9/oWHGlJpjdKFVxLv17KBxGiVEsfgSkul+9ikZluiayGCOuhF
	XXUC7lM/Skl5T3IOrITABEzS57L52a5I5NqPXdgHXK1Pmiei6PuH1fiwjeAnO3iU1xhY/I+/EWH
	l9ZxrCHJ9304a7YzB8d4A/n9L5H/QjGtUB6CWLwpUIXtk0AOVqB31Pvn3uM2WlQgEsMwjq1qFbU
	66qfRePEvzvtTiTktLzmyJ2R7cNJO6aRjsW8Ik5MEg38ZIv+E/nzJN+U4WdF/418GyTmK6Qqaxw
	G/zoK8bkSg==
X-Received: by 2002:a05:6808:f88:b0:4ab:318c:6b38 with SMTP id 5614622812f47-4f526442119mr5877208b6e.1.1791083219254;
        Sat, 03 Oct 2026 20:06:59 -0700 (PDT)
Received: from starship.unifi.local (107-216-42-6.lightspeed.austtx.sbcglobal.net. [107.216.42.6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f5249dc2e3sm6503800b6e.11.2026.10.03.20.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 20:06:57 -0700 (PDT)
From: Lawrence Lin <deduce@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Avoid quadratic symbol lookups in ftrace_module_enable()
Date: Sat,  3 Oct 2026 22:03:58 -0500
Message-ID: <20261004030438.434327-1-deduce@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com>
References: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Krzysztof Wilczyński reviewed this off-list while looking at carrying it
in a distribution kernel, and raised two points. I'd like to bring them
here, with numbers, before sending a v2. Cc'ing him.

1. ftrace_cmp_addr() duplicates ftrace_cmp_ips().

Agreed. For v2 I have dropped ftrace_cmp_addr() and moved
ftrace_cmp_ips() up, above the FTRACE_MCOUNT_MAX_OFFSET block, so that
ftrace_process_locs() still sees it on architectures that don't define
FTRACE_MCOUNT_MAX_OFFSET. That builds on x86_64 and arm64, and on x86_64
with CONFIG_MODULES=n.

2. Should the sort use sort_nonatomic()?

I timed the collection and the sort with ktime_get_ns() on a Ryzen 3
3200U (v7.3-rc5 plus this patch, debug printk only):

  module     addresses   collect     sort()
  amdgpu        64983    0.41 ms    36.4 ms
  mac80211       8199    0.11 ms    12.0 ms
  nouveau       19354    0.06 ms     9.6 ms
  kvm            7993    0.07 ms     7.9 ms
  radeon         9882    0.03 ms     4.6 ms
  all 141 modules loaded at boot:
                         1.09 ms    94.3 ms

So the sort dominates the new code, and amdgpu spends 36 ms in it.
It runs in ftrace_module_enable() before ftrace_lock is taken, so it is
sleepable and is preempted normally under full or lazy preemption.
What it does not have is a resched point, which only matters for
PREEMPT_NONE and PREEMPT_VOLUNTARY. sort_nonatomic() would add one, but
commit 340e3c5165d4 ("iommu/arm-smmu-v3: Replace sort_nonatomic() with
sort()") removed its last caller with the intent of dropping it, so I'd
rather not add a user. For comparison, the lookups this replaces took
about 4 s for amdgpu on this machine under ftrace_lock, and needed the
cond_resched() from commit 4099b98203d6 ("ftrace: Fix softlockup in
ftrace_module_enable").

Is 36 ms without a resched point acceptable here, or would you prefer
something else?

For reference, the cold-boot A/B with v1 and the v2 change, on the same
machine with a distribution kernel (linux-omarchy 7.2.5, amdgpu from the
initramfs, three boots each):

                     stock     v1        v2
  amdgpu probed      6.17 s    2.03 s    2.03 s
  kernel (systemd)   6.64 s    2.48 s    2.50 s
  modprobe radeon    155 ms     83 ms     83 ms
  modprobe nouveau   468 ms    141 ms    138 ms

(medians; radeon and nouveau have no device on this machine). The list
of functions in available_filter_functions is identical across the three
(84301 entries), and none of the boots logged a warning or soft lockup.

The same three kernels on a faster machine, a Ryzen AI MAX+ 395
(Strix Halo), three boots each:

                     stock     v1        v2
  amdgpu probed      4.84 s    3.80 s    3.81 s
  modprobe radeon     47 ms     32 ms     32 ms
  modprobe nouveau   130 ms     60 ms     59 ms

The saving is smaller there, about 1 s for amdgpu rather than 4 s, as
expected with a cheaper per-symbol lookup. available_filter_functions is
again identical across the three (84676 entries), and no boot logged a
warning or soft lockup. The systemd kernel time is left out because on
this machine it includes a LUKS passphrase prompt.

Unless there are other comments, I'll send v2 with the change in (1)
and these numbers in the changelog in a few days.

Thanks,
Lawrence
