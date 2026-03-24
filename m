Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E51C358388
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368024; cv=none; b=OdwfDs//RRa0lC591FDLzaqMsUMVyswdwXJJKGGe0ip/3TPg/P4JK0PMAyqCESWp4TfErQDFO48o0SIvE0VKmFHcWHojO93+WQpXIGN7gCwb6aNwyp80HKwpE8sVBKiGb9zwhoveSlWte7zR3v+M4D8EoKXS198Cb9H8tslqcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368024; c=relaxed/simple;
	bh=o+cMkXZ4AL0yvc8YxODTxfgOpONgzCRH94hoPaiSk6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQeXOJs4vDISNP0ac+cI7N/qFkNEHCc3CPIMBW7Dwc/tE072SfequGC7KKqcSyMsF6OdpJJFEcWpODGdyWPNja2X4EI1oXHG11CIfzMYXcwqnUD0h+iUlqjouojZKVVprdQaQdgyJcrlkSz4Kw/06LpMn9vnI166z2S9KvpmAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KkAkN/7n; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KkAkN/7n"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so10318645e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 09:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774368021; x=1774972821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JZud2txb2+gokYF6qCswpOqRe8hThYc5D0An7F/T1G0=;
        b=KkAkN/7nZwFHSlOrMHhFIszI7EZfNiGhn2NZaPp3knF8FbvT7qhEsjnixr18ZsPQ8F
         Np694D1YOe7BoBzB06L6vrk44wLjWMWnkgXEjYUCNuk/nUAcrOazMZ/scQP6rctvOpQ8
         LlUa3xx/PjV6E1b47uLOkTh4GrxZBh25woSoYps5wJzpOkbCjEWWEtHoIFpGIpZoSFIj
         FX+VQxihc19Umdtg1EwdS+Qt0Q/v4QCIIVnV5969BwS118bpndgeKe1mzo4Y6KDlWneV
         JFTCVf11QpRpe1vcHy7jPH+oE6oAejDbwwylsLzsf9nhEs0vc51h886yPsVqpln9Xq5q
         3JFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774368021; x=1774972821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZud2txb2+gokYF6qCswpOqRe8hThYc5D0An7F/T1G0=;
        b=gbLAJPWSRRUw/s+EnJi8A6JFXUErb556I3NYll2K31rrHdRxUUMMwvG81EGAir1wk2
         gbapvsNA+wDX49y4lZUh3lX3KMlcSsZQylmbbzsC2QYVTn5Tn3KviJJIvPg/IAfHXMkB
         De9QFlJodCMXDRG52pdczBzocIbgYL3ohTlOnTRZyVh7MUldWdaDzkeaxvUTPCAVeE1F
         OZNFi7tRSncCKdS370ttRGck6cuAQotZxqe5HfAwRUqFd4IS6hJAnP/rAWMkrBSPaCp4
         UC+tay8Klah8dUVQXQTMGSbcgYLnurprU9vpaX7j2DeWAABfLjOfEFv3xvbWUXdgI3O8
         jK6w==
X-Forwarded-Encrypted: i=1; AJvYcCV4CZIZT3XdN8tjVr3qfM8Lfb6xWbq/deBL3sTGOyBaJON/qoG+FchpWDp+R90n5q4I9ZCSVnjSmmwQ6Yq0uMky94w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotgMYPobRpX7JGboRrMp/Fts7MPqn0OXDctcU9hV6QNvgh4XD
	ewUq2YfBohdSiZ0Sb+seW9aFIq2oT8Q6Z90Xp+hl4lcW6G7eqUWNUcGa9GFvhGl9AHw=
X-Gm-Gg: ATEYQzzfOeaw4YgV0R1UPMDxORtRnu5kyg/xgJeS46sbS3Yql0XD4OAnETqlmw9Gnry
	zmHu9T2uDYrq5qGiXJLB6PwICzdvQYdZEsAYAdyf1bSdgodtVd602095is8JTH4hEZXH8JnSIxm
	q6ForTX2DsiG3RulGUE38e5KHc3ueqDq/aIIMSNCwmh4eZVVkjV4dHKzZwJibVnZ0r3XZUV5d3k
	0ej4Omh121kbDw9+UvvYz2QvVd0P6pIOyyCQlEZflQo1lVQxH+AlCGKdHjSWkDHo5tw6XegFD5s
	uMRzklr3bKoc1LD+Ie3isKVlN8RvhYnBAth5iLMjf249CJQd8ATn71O9FkZ2i276EQ6Uf2j2fq1
	+YdmS9PJQEzscdHDPQw2ANOdzLha6ieRo3GxKxcGPLniM3qgpaQLVhqu9IwxnoapQj1z9GkMDa2
	hLxc79TfI1s25qiQvaU2Haw+yAw5EKshjQPix/c7i/tHMm
X-Received: by 2002:a05:600c:8b31:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-487160881a5mr4153985e9.31.1774368020765;
        Tue, 24 Mar 2026 09:00:20 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487113c4eb3sm68147455e9.0.2026.03.24.09.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 09:00:20 -0700 (PDT)
Message-ID: <282574df-7689-4677-929b-b844e7201bd5@suse.com>
Date: Tue, 24 Mar 2026 17:00:19 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module/kallsyms: sort function symbols and use binary
 search
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-modules@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org,
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jordan Rome <linux@jordanrome.com>,
 Viktor Malik <vmalik@redhat.com>
References: <20260317110423.45481-1-stf_xl@wp.pl>
 <b6030f42-b4d2-4e52-acec-76e25c0f40db@suse.com>
 <20260324125304.GA15972@wp.pl>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260324125304.GA15972@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/26 1:53 PM, Stanislaw Gruszka wrote:
> Hi,
> 
> On Mon, Mar 23, 2026 at 02:06:43PM +0100, Petr Pavlu wrote:
>> On 3/17/26 12:04 PM, Stanislaw Gruszka wrote:
>>> Module symbol lookup via find_kallsyms_symbol() performs a linear scan
>>> over the entire symtab when resolving an address. The number of symbols
>>> in module symtabs has grown over the years, largely due to additional
>>> metadata in non-standard sections, making this lookup very slow.
>>>
>>> Improve this by separating function symbols during module load, placing
>>> them at the beginning of the symtab, sorting them by address, and using
>>> binary search when resolving addresses in module text.
>>
>> Doesn't considering only function symbols break the expected behavior
>> with CONFIG_KALLSYMS_ALL=y. For instance, when using kdb, is it still
>> able to see all symbols in a module? The module loader should be remain
>> consistent with the main kallsyms code regarding which symbols can be
>> looked up.
> 
> We already have a CONFIG_KALLSYMS_ALL=y inconsistency between kernel and 
> module symbol lookup, independent of this patch. find_kallsyms_symbol()
> restricts the search to MOD_TEXT (or MOD_INIT_TEXT) address ranges, so
> it cannot resolve data or rodata symbols.

My understanding is that find_kallsyms_symbol() can identify all symbols
in a module by their addresses. However, the issue I see with
MOD_TEXT/MOD_INIT_TEXT is that the function may incorrectly calculate
the size of symbols that are not within these ranges, which is a bug
that should be fixed.

A test using kdb confirms that non-text symbols can be found by their
addresses. The following shows the current behavior with 7.0-rc5 when
printing a module parameter in mlx4_en:

[1]kdb> mds __param_arr_num_vfs
0xffffffffc1209f20 0000000100000003   ........
0xffffffffc1209f28 ffffffffc0fbf07c [mlx4_core]num_vfs_argc  
0xffffffffc1209f30 ffffffff8844bba0 param_ops_byte  
0xffffffffc1209f38 ffffffffc0fbf080 [mlx4_core]num_vfs  
0xffffffffc1209f40 000000785f69736d   msi_x...
0xffffffffc1209f48 656c5f6775626564   debug_le
0xffffffffc1209f50 00000000006c6576   vel.....
0xffffffffc1209f58 0000000000000000   ........

.. and the behavior with the proposed patch:

[1]kdb> mds __param_arr_num_vfs
0xffffffffc1077f20 0000000100000003   ........
0xffffffffc1077f28 ffffffffc104707c   |p......
0xffffffffc1077f30 ffffffffb4a4bba0 param_ops_byte  
0xffffffffc1077f38 ffffffffc1047080   .p......
0xffffffffc1077f40 000000785f69736d   msi_x...
0xffffffffc1077f48 656c5f6775626564   debug_le
0xffffffffc1077f50 00000000006c6576   vel.....
0xffffffffc1077f58 0000000000000000   ........

-- 
Thanks,
Petr
