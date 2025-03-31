Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3995E1E5B60
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427192; cv=none; b=trOwdMxklOCXfEVLFQoR3GWVoiP357EfThaJe5zfpoSnfkRdp0e30EIsN23cc2jOqGYBYcQ9nPVdad2Q6lPET0lQ7NVGgOK7+k4tndH45S4CpJitieH+3+awvk4ykQ0xD1OKPISoolVHTOAAmBRhXU0f5cdehq/b1I13QIdtwlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427192; c=relaxed/simple;
	bh=P6DCTUit0leEkPXg7yvciyfLzZCMNlz+axqKHwql/cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UKvD058P+55nFV/unbJ4fPss3AZd0+XuNOsq9GLBMEI6tstoKxKFrgNZWoH/0cCWaenc+aTLFDr17j8lbEushf0TfoutGh2V5KxZ3XQPfOaUH9gjrcgdle3zcUjdfrWIoyaG/dJDEMY7PgDArZN0RbScHiWzvmZzo7XQtk6+2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bdFmwDFu; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bdFmwDFu"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so35487085e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 06:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743427188; x=1744031988; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcmYk5PTzxCtOJOaVVP5nkeOuljxOTS0F0qSnk/8Fxg=;
        b=bdFmwDFuhB+0Gfw/nwoixHXAPnagSqngq0oFhy2OTzNvXJUcT0sNuoFCClUQw7uBuz
         KYkkxUpMQ+H3ShxhEUeJI6F60G59kUzJCwNBboyjzYLrbyihXmIwVodeSQz2j9U0IvN/
         zF1Aivt/B5O02E+hiCLTunMTIrj9e0kfF2Bafh95oUgsPZVqqcOYqL4xu+36mTrTv6cA
         sH5hF3AAX74wkDfaZ73JFf2ssrSIvIXT9UDDCjafcx0zbWkFkg8UvK47i/JDfqkbincz
         F8Gj8ccNJhtEYlT6HVf05ggMwyv/gzfd28sexlGo4qjUSra8fi2vHU9FWxfmB6Z2qJbB
         hK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743427188; x=1744031988;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YcmYk5PTzxCtOJOaVVP5nkeOuljxOTS0F0qSnk/8Fxg=;
        b=mShOSjEvab1PmfnKhRM/ZJZD0fKpCWTQyoyi/OkJIUL5XuG2uJCnRGorDJDX5Smh4R
         k+4Os8W7qo4B6LMt8BO/v/IRMW4qosGoCloodUnfuCxtHX0pMdlY0xa/mYpCKUrXe7tq
         oUginKg3OcESshPbUPdmAbMUM2vISUxl7MfLbqxX6vZt+Sb9EWw1ALekOxyoaX6vQXcG
         js5kHGrxAI29Uu4pv8ySL96n/zu4CpgVUud0+7CH4gPxPHQd1FCxnh1NajjPGB16LjNP
         YZGW5RXdZrj7ql+cViycF1nl1cBnsMOEZBrNlYDwrn9DX0PGJX5RazadRW8p56Dt5O1K
         Fg5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqHgKvN84gGuvJESge+876wMOpwA4GyyFyuCiJQrV+nKuPYCTe0dLx2rHjaAUoqT7tQFt1xbqpHT3gDu3OKSazhWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzOrUdnxKd57kbeS8RCsUtuWQQXmcUghtE+KxklX+j3bcOHrP
	1URJFhq5C485cIf71x6YiZsfLi0DiBQ6D/lZMz8yqXCuK5Z3LqtQswD0XtcW8MmVN2Ta/io7eZh
	rD+dmn5jH
X-Gm-Gg: ASbGncvB0WoUdkB6jdNel4vcCYy97QuuzWI5HmdM5xlWa9IrtnCGphfjswyzZRGYcDz
	Fv8B8hD7TTd1rCQQNZw2sy+kSC/ZjD3UixI3OlyOxpX3qCthyTNFlY9SAW+c9404kouX1fLsIAd
	5vnF83hlL/DSRhscN8d6+hUVRSPGG377bAZT80f1mRQVH1GNz/0/0fcXwVwCe62j0WDVi2sw6Lg
	3KjE+gAtuDkS+UNvOhZyf6sUDljmD1JLHk89NuuHhmuSNoy8d/aPcnRJImfxnrsEGBQSklpV/f0
	d9l8H7zjoB/vFDS1CI+cr7eMXRqXaHPujq2JrsnkR3S0yt9cjWb0crJmNoPse5vLcSp/NgJ+Tcc
	UHWwiv99MAYB/P3xd4iKgbUkp1W9yb3DMnNpF3g==
X-Google-Smtp-Source: AGHT+IGZqmArJyrihK4euVLU0horXdZgOg53706JbhiZUWs5TDnkpgzuRWwj3lskoRyG6Hkk8G0VLA==
X-Received: by 2002:a05:6000:2b06:b0:399:6d26:7752 with SMTP id ffacd0b85a97d-39c12117ad8mr5124011f8f.38.1743427188556;
        Mon, 31 Mar 2025 06:19:48 -0700 (PDT)
Received: from u94a (2001-b011-fa04-3f62-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:3f62:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1dedcfsm68393265ad.193.2025.03.31.06.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 06:19:47 -0700 (PDT)
Date: Mon, 31 Mar 2025 21:19:36 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: "Naveen N. Rao" <naveen@kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
	Mark Rutland <mark.rutland@arm.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Vishal Chourasia <vishalc@linux.ibm.com>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Miroslav Benes <mbenes@suse.cz>, 
	Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: [BUG?] ppc64le: fentry BPF not triggered after live patch (v6.14)
Message-ID: <rwmwrvvtg3pd7qrnt3of6dideioohwhsplancoc2gdrjran7bg@j5tqng6loymr>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

On ppc64le (v6.14, kernel config attached), I've observed that fentry
BPF programs stop being invoked after the target kernel function is live
patched. This occurs regardless of whether the BPF program was attached
before or after the live patch. I believe fentry/fprobe on ppc64le is
added with [1].

Steps to reproduce on ppc64le:
- Use bpftrace (v0.10.0+) to attach a BPF program to cmdline_proc_show
  with fentry (kfunc is the older name bpftrace used for fentry, used
  here for max compatability)

    bpftrace -e 'kfunc:cmdline_proc_show { printf("%lld: cmdline_proc_show() called by %s\n", nsecs(), comm) }'

- Run `cat /proc/cmdline` and observe bpftrace output

- Load samples/livepatch/livepatch-sample.ko

- Run `cat /proc/cmdline` again. Observe "this has been live patched" in
  output, but no new bpftrace output.

Note: once the live patching module is disabled through the sysfs interface
the BPF program invocation is restored.

Is this the expected interaction between fentry BPF and live patching?
On x86_64 it does _not_ happen, so I'd guess the behavior on ppc64le is
unintended. Any insights appreciated.


Thanks,
Shung-Hsi Yu

1: https://lore.kernel.org/all/20241030070850.1361304-2-hbathini@linux.ibm.com/
