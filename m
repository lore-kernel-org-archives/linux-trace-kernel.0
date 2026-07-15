Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36B86341
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 03:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784085185; cv=none; b=EoRYqyaPaCR1mge1tf56qZ1LwQQX9Odfn2QepQwNc5+q4T7pvjcXSbSNvkdB0tZBKg6JEuoRwzTPmVubUgeKohWh6VTtDguXdtD6sKl5YCb59je8z0uOxui4yfEbYnyUhLBWZAwVT8pOxKobcwktdmWJ1wV3nLMbj2TitkTwjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784085185; c=relaxed/simple;
	bh=7e+9Wp0EE/Prg9yOvSXbuLFhvaCFKgb77Cj+Z1NHugk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=etmHhSvlUsvDHrM7MY/IgUL60OTv5B9wlZces3l4FxJo5PFyNMewat32/ZiObiYtczzToSatcUATqAzedxbvdp5G0kkhXj7+oLLAcULmNaZ92J3UhWGXKV+rxU+SDpsN/5a7BAOBhtJIPQvWqy5NAV2ppGI5MAupFyJFwPQxe5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msuBJZM5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msuBJZM5"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84a652535dcso216786b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 20:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784085183; x=1784689983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7e+9Wp0EE/Prg9yOvSXbuLFhvaCFKgb77Cj+Z1NHugk=;
        b=msuBJZM5rQ+gE/U+lEiGH5tJFAQKqYh+bC6LQ3EmAgl4YIMylc+VMfrCNK824vAkYn
         XANLqRh1fvOsO2lHbLw61hjwVXXwkcsjkD+3AyO3tOz0frovp+ArQJRm7u4EZmcDh1i8
         CBb7WQIC56En3NkEEpJsWJAdmMBJq+S3HnGb6fRQ3clWvG51IxJqhDUJl7mUTSI9MYrx
         I7ni4EBv1GoaKyoyGiErSJ7JNL2UblZHCcAZtVloIG7wzPV0d6LgwpIkc+wiPNsKh2e2
         TAGZEA+VB40fB4sb3nZTB0SWBSsl30eqGwbSA155rgATHEWKz8fiebEVVtxCXEM315SE
         a4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784085183; x=1784689983;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7e+9Wp0EE/Prg9yOvSXbuLFhvaCFKgb77Cj+Z1NHugk=;
        b=emxovm4Kg9sEG9cGIoraiJ7H91sCZA2E+LHOvRe6ME8WNIuL7toEvDmNwwkpPqxDRg
         pTkAKmhtkSgQl6X6rIb3OeF/1H4ncdDgLIAMhzIjh8/gMPB3EoH6SJUvCNCmyWDv6RtZ
         yjH/Szhs31WvaFhAvRQlTzL908baupr9rROUmVKsJX2name8qOLtmXM1tEoiqi+m77ur
         /pt6YhcuHI7q8ky0vqfytybbMUkNog8c5WL5fF5MS8e1TeB/QkkTn7YRUN87836folTJ
         nDLvXa5e4t/HTgq1cwtvREfdMYs/gt9NE/kyMEa+iZ0cm1izgYY5YHiP5T+jRuRMldpQ
         ko9Q==
X-Forwarded-Encrypted: i=1; AHgh+RpIRfnwTb9lkdYQLqkWzTAWN5oPMSwQHpGrH2C4zpt4RBrSvP5sT4JsyRvhbfesldj5Amxp/EwEc+YQuE1JVYmXSjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90UYgKvP6L2pwm7NA5Ljihcg4AcrQXUaompjem5r9DGi/13OK
	OSOyc+RuF8mGEA/+FdL8nSglfJKn7UGlfflU292suFdPQLh2irWCRJ8w
X-Gm-Gg: AfdE7cn7o4Pn+9D638gNlXcA2RU/b9iYX+KeM10YWO17kybraTBpxVuGt39NAqY7Mif
	HMCoqd68eiMDCjq2t2Gl8G2BPO9zOzGzjb7Pbi477oxkW5G+sbx8rSx9Vs1EiDgcuXLlCW22aNQ
	v8L9Lw0VY8hKQcFa36BCXu4LbKm2o1BXBPG8XyJ7PgIGQkkpXhtFNFvO1p+94PGEpqcvozKUtVc
	cAgKgfYWbNO4WHAo4q3dvobC9FoBg7UEszP3O+lG7I+8SxDZ+Jqjd5I2VIKJLPWYBo92SqWy+jf
	/It/okpPj/nBgXMk2FVMFqq9lrJz0hSXcKjp13Tw+EXGtUKWrXQC1riHZ0GCWoFke8pXuscAXwJ
	uxXOkj7rFWT4eDvVd5sENUJsw8NqPXBP7+EAsfC1kJLXtuPIwvqin5SmqqbTNLbsLF4mL0e1cGh
	OyhjddPTb7tYiM/H6tBcLiCs3dIto9RBRf9asFK0QX9yJ9tZxljjb0
X-Received: by 2002:a05:6a00:987:b0:848:2f84:f427 with SMTP id d2e1a72fcca58-84a6736d4d0mr897505b3a.64.1784085182776;
        Tue, 14 Jul 2026 20:13:02 -0700 (PDT)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:d1d2:d044:5a81:884])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f818eaesm2347110b3a.58.2026.07.14.20.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 20:13:02 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v4 1/3] trace: add lock-free stackmap for stack trace deduplication
Date: Wed, 15 Jul 2026 11:12:45 +0800
Message-Id: <20260715031245.2571869-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714171144.4537f163@gandalf.local.home>
References: <20260616064119.438063-1-lipengfei28@xiaomi.com> <20260616064119.438063-2-lipengfei28@xiaomi.com> <20260714171144.4537f163@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

On Tue, 14 Jul 2026 17:11:44 -0400 Steven Rostedt wrote:
> smap->entries = vcalloc(smap->map_size, sizeof(*smap->entries));
> Make the error paths have: ... goto fail; ...
Will switch both entries and elts to vcalloc(), and collapse the
error paths into a single goto-fail ladder (freeing in reverse
alloc order, including the drops percpu).

> Do not add anonymous blocks in functions.
Will move the cpu declaration to the top of ftrace_stackmap_reset().

> Really should have ftrace_stackmap_bin_entry have a flexible
> array: u64 ips[];
Agreed - will add the u64 ips[] flexible member and use
struct_size(e, ips, nr) in stackmap_bin_open(). On-disk layout is
unchanged, so the bin format stays compatible.

I'll also fold in two issues I found locally: a missing lock on one
init failure path, and TRACE_STACK_ID not being handled in the
function_graph output (it falls through to print_graph_comment()
instead of being punted like TRACE_STACK).

One design point I'd like your steer on before respinning: reset
checks tracer_tracing_is_on() once under trace_types_lock, but
traceon triggers (ftrace_traceon / traceon_trigger) can re-enable
tracing without that lock during reset's clear phase. As far as I
can tell this is a semantic-contract issue, not a memory-safety
one: the map is protected by the resetting flag (get_id bails with
-EINVAL and synchronize_rcu() drains in-flight callers), and the
ring buffer pages aren't freed by reset, so the worst case is a
non-empty / inconsistent buffer after reset rather than corruption.
So I'm leaning toward documenting reset as best-effort ("stop
tracing, including traceon triggers, before reset") rather than
adding machinery to block the window. Does that match your view, or
is there a ring-buffer-state hazard I'm missing that would justify
blocking it explicitly?

On the element pool: your `-l '*lock*'` run is a good illustration -
the ~326K-line stack_map dump is the 16K-entry pool (bits=14)
filling up quickly under broad function tracing. I'm leaning toward
keeping eager allocation for v5 (it keeps the hot path free of an
allocation-failure path), but I'm happy to switch to lazy allocation
on the first 'echo 1 > options/stackmap' if you'd rather not pay the
~8MB resident cost when the option is never enabled. I'd keep the
stack_map_bin interface as-is.

Thanks,
Pengfei
