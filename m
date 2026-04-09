Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFC3B9DAD
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Apr 2026 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738240; cv=none; b=il2EXNDFNSpgJ59Hx3REuJGHWg4+Psmz5IeKIc+KWD8FLGDBmxq1OvyK8N9hCX/lxyzwFNG3/GAPp2OcBCWTs+0Id749voXybi1GloopN6oOPZVb3fF5CligCb4S3mhJfTemUnUATnFp684w2RMM+ueA13H6w8s7UxtNhLt1yzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738240; c=relaxed/simple;
	bh=kXqVC67K7Ok0URFdMQss6lTIGbLrxnPL13nMpdUnN/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dX/ALoN84T5nvxWfCCquiANQVpX4mASwF66SYAauZpX4QM+MB4aTV7c87ASUcfEDsv8VbaPNWeLp/wxY8AuKANPGGEjNZAo4PdY7lOSi3+YRIoQeKmOnLugFYZ+55CD0hJfBPcdYRTusv/xfRlPV6qe7QvpDVEIuIrczjoUZPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SueCztIF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SueCztIF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso9570805e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Apr 2026 05:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775738238; x=1776343038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXMv5P2otA71oVxzctM87KJsMKwFOqSK4K4FBNtEt2c=;
        b=SueCztIFgURyMdqUY2D5JdT1xiLTmI/DfOmKuqUjDrd2r7hrlpHxDhhSrvnzauD/Db
         gd6XWOToDf651nfNocXYFmCXeSjWtm1/Re1Kwuimr/GaBtNn5hFcjPIsAsGQC5UFemDo
         DXcEOPpGOFkj+crkWm/fpAb8KgP6izmquk/0l8LF/z4z+bWAF6p9yXDUAqFW5xyfCb8e
         QlYTEztF/CbIN8HI2K7HJBXnyiS3LBmN30ag8w4ksIpVltauPn/itCWb88qd5hCDc1lH
         EtLAvTKieQDEOYzX0KAMdhEDB3F9CdwpTFy3Ko4/nrVwS9IA0r1iocNFM8HhdcxD2Q56
         MqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775738238; x=1776343038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXMv5P2otA71oVxzctM87KJsMKwFOqSK4K4FBNtEt2c=;
        b=ad4jDoXU2flkuJgN+8wOlZFEUsZHKYXT+gk/evJUo/tNq8dG8lJLtGHr/F+VC1ilVw
         Wm4b5bbrHK4fVEw78QIf3Ai7PaMS48v0LQZAy1JxKsGfYM4l4sjT+6/DKySCe4/z4MyY
         xAS2++47RGxjAb2Ok/msW38dJHQdgfzF73RJjYvuIf6BkwJncawOo1TCOe4kj9xIkI9y
         MiOt1+qSga9hTc1JZCbXiFyyNDpko526ByG4tuACpofa+Vjfx9T/DOotO5qSFGI5POZ/
         ha69eqXGoyWEohAlsjhPfhdt2bYHaEy1d1qwrwjqPgrJrie0QIsHpLDxqojXjJG6Gmxz
         /rSA==
X-Forwarded-Encrypted: i=1; AJvYcCUqw9UxTIfZUo7/eeRJzg5TmXFziU4u0DSSGhmsHcx3IgOdV4mprKB93g4nrh0p/eLei3qn1PqU8K3QVc1+awcyuhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY0qhFolI7OHE0akb0Kxkza6vv+CCNTwOL1JDzlXCZQXLx8Vbf
	puHO0fmXcyjvyGqu2MXgs9z22hJPuMprUh38A2tpwkQQvNP4naa9HxZS5V2k3AdeWTJvTUvP2Da
	Orm57BoU=
X-Gm-Gg: AeBDieuHoPZU79dn6BT3gFtvvdHEurS4+iisYO0lNvAzuUzDQlehsm5/ae7MvBlxPuP
	LhTkuXBkxjXg7J4Li44ANiNoz8PxZI7XKy4khaOTrqj9ar2pBHSH00xgEEypnH8sjcKQSZMKcJU
	vFuYwX0J5URohB/ECKshdhYd0dni9TnrtTLZaFQ+bgGLG+QsyQ9PYqeVFHNRGa4eQFQvMb1HeqX
	gl1/SwTy/Y/g6dSZ/IH6zSdyIMdyYp7Sj5qCvct0b7ZBS0D+tceBUL3rEEPlVy03vdjQwd9ez6G
	wBxzHgYL8k/8WTZfmWh50rt7RRiCAtWQHoXl2w+SIiedzibcnndlWX3/Dln3Yi6BgPR0YJMQ4eQ
	uVfe3YWowyqE+/0f2dqBAhTvbTde41nxRc/yX4zXY/1/SUgBbOdGfgxquYE0niC+HOgs3u0J7Zw
	tvzEgMGuNJEatqPMv45PhCSwHaEbdTiZL2GnDZXgBCUPaT
X-Received: by 2002:a05:600c:314d:b0:488:bc6a:5285 with SMTP id 5b1f17b1804b1-488bc6a538bmr157487535e9.30.1775738238024;
        Thu, 09 Apr 2026 05:37:18 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cfa75ae2sm100719905e9.14.2026.04.09.05.37.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 05:37:17 -0700 (PDT)
Message-ID: <47cd7c31-c914-433c-82d8-22875c32122c@suse.com>
Date: Thu, 9 Apr 2026 14:37:17 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: preserve module tracepoint strings
To: Cao Ruichuang <create0818@163.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mcgrof@kernel.org, da.gomez@kernel.org, samitolvanen@google.com,
 atomlin@atomlin.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
References: <20260406170944.51047-1-create0818@163.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260406170944.51047-1-create0818@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 7:09 PM, Cao Ruichuang wrote:
> tracepoint_string() is documented as exporting constant strings
> through printk_formats, including when it is used from modules.
> That currently does not work.
> 
> A small test module that calls
> tracepoint_string("tracepoint_string_test_module_string") loads
> successfully and gets a pointer back, but the string never appears
> in /sys/kernel/tracing/printk_formats. The loader only collects
> __trace_printk_fmt from modules and ignores __tracepoint_str.
> 
> Collect module __tracepoint_str entries too, copy them to stable
> tracing-managed storage like module trace_printk formats, and let
> trace_is_tracepoint_string() recognize those copied strings. This
> makes module tracepoint strings visible through printk_formats and
> keeps them accepted by the trace string safety checks.

The documentation for tracepoint_string() in include/linux/tracepoint.h
contains:

 * The @str used must be a constant string and persistent as it would not
 * make sense to show a string that no longer exists. But it is still fine
 * to be used with modules, because when modules are unloaded, if they
 * had tracepoints, the ring buffers are cleared too. As long as the string
 * does not change during the life of the module, it is fine to use
 * tracepoint_string() within a module.

The implemented approach copies all strings referenced by
__tracepoint_str and keeps them for the kernel's lifetime. I wonder if
the code could directly reference the original data and handle its
removal when the module is unloaded, or if the quoted comment should be
updated to reflect the new behavior.

-- 
Thanks,
Petr
