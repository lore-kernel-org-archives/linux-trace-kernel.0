Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9833A1494D8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 May 2024 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324547; cv=none; b=OvJMT/Fj7achKFN1RMMFOwa54EcVhhZoY3f2DZ90VgCUsoWHQ1aazuAaGv3HVpzdk0FOiHQzj560PDkLcuinpBHG5KKkVslbcbQEN4s/ykvOLzW6KUUoMMu57HymnKAap8d/r4Pzi9IUZMP9iyQNXUf4t5HaliAe2db8pWRb9/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324547; c=relaxed/simple;
	bh=693jQWAREfUdV/HbHgjOUtkEmsrn6/m+v+a7zyIHVAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUbF+rSvDTx94Z9Lam9vPfLysqshzXrg/hNsHi/SbjyksJq5QjaRyuB2Kmcf+0JJRU1DJO7NFRk88v40NpKWMccw3AD3zKMytahCOXrYUjNNqQoqy6iNzv8ExncfFpuyLgWfaMsGruftVub6/uo7YDYAle/rrILpaUbVdAAExZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bGOtEg9z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bGOtEg9z"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1edfc57ac0cso4814215ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 May 2024 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1716324545; x=1716929345; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx+dQv0EXvgLDA60wWUrjQl9mWisglv5nVrYagP1xdM=;
        b=bGOtEg9ziXoNqwXkpqdc4PZ9a/dAbvsOdVOv6Ku83BXj1uzMRgUexqjLybC6vjdwuF
         vyl5BeGOLjczKNcCkP/tIjHejxsaGNV1t1mptXMu8OHmNVQUVRr1aFPnnrhS+z7u9rSi
         TyEsregyM6IsQNW8QbmTkWsVfnJ3mZnyqD95NnLJ649AXvr958c52PadJUiNq6PoD9aX
         5LE815kSLpBWQ9xLvQSEDW9VCUFIgrYXOiFuQ4+2lTiTvo81nZFHYjvdMVPDT7ZwcZb8
         mHVe/kOcJg60Ee14FH4DclNTU8v481dskopZPkQVXtpuo2pu6aNhYA05mXo3veNx73Y9
         WMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324545; x=1716929345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx+dQv0EXvgLDA60wWUrjQl9mWisglv5nVrYagP1xdM=;
        b=jHOBrRpgwyAbhVpdx8d7CjAzPATazL+RnW6YavI84s5/7Q12FkHjdMmo0T+X8JCEDN
         BpF1yC4H/z0RKLMadR1KQ+ii6Gvc0XlKEqgUryBUyowE8jlMkay0tFmGEgGojkunLZBX
         9BGRs5LoHIs2AzH6+tfjpnC5T/JiN+Tg+vBqDvMyxNjW+Og6tel2dHdvvE68vD9Q4eR1
         OgDqlJippO830QDKAqwxjAbbx/Y0PSPmZsOPSY8BYgqLyO8pHSVcAIrvgkvbuGZq6Ctm
         x4Jv+yb2ULAC9ENNPEyHuK0InMYmkJAfe9kHWJRSHM8fg25badKfYX3fRnXUlbOLHoJR
         V+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjYS2UnxO9NCh4BCDX25NJD+NIW0hMMNdlqMYUyPfwyfFtODKntAxK1tOgVQWr4r5IKRULEpfEZ4Y4kRdoK15Y0grshiDj9D1Bw0qrXxgux+D6
X-Gm-Message-State: AOJu0YyuIwonzf0Ivtixpl1nvzT7hrpy+lx3nfD8DQ/9t1qW4TJJMHhC
	hhLnyGXA1FGBznh4adPSjwVw2uqBUvq6nAPScMam1gGhnSNln32GOOQE76RyLQU=
X-Google-Smtp-Source: AGHT+IHlwL8HnlxOnwn8kJ0fVFV55sB/RolsKAbelV78JZZEngYsdS/7UN3t2OKQs87EBwQocJT9nA==
X-Received: by 2002:a17:903:8c6:b0:1dd:bf6a:2b97 with SMTP id d9443c01a7336-1f31ca37710mr787045ad.60.1716324544792;
        Tue, 21 May 2024 13:49:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f0958d1e3csm114310545ad.191.2024.05.21.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 13:49:04 -0700 (PDT)
Date: Tue, 21 May 2024 13:49:01 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Subject: Re: [PATCHv6 bpf-next 0/9] uprobe: uretprobe speed up
Message-ID: <Zk0IvZU834RQ7YKp@debug.ba.rivosinc.com>
References: <20240521104825.1060966-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240521104825.1060966-1-jolsa@kernel.org>

On Tue, May 21, 2024 at 12:48:16PM +0200, Jiri Olsa wrote:
>hi,
>as part of the effort on speeding up the uprobes [0] coming with
>return uprobe optimization by using syscall instead of the trap
>on the uretprobe trampoline.

I understand this provides an optimization on x86. I believe primary reason
is syscall is straight-line microcode and short sequence while trap delivery
still does all the GDT / IDT and segmentation checks and it makes delivery
of the trap slow.

So doing syscall improves that. Although it seems x86 is going to get rid of 
that as part of FRED [1, 2]. And linux kernel support for FRED is already upstream [2].
So I am imagining x86 hardware already exists with FRED support.

On other architectures, I believe trap delivery for breakpoint instruction
is same as syscall instruction.

Given that x86 trap delivery is pretty much going following the suit here and
intend to make trap delivery cost similar to syscall delivery.

Sorry for being buzzkill here but ...
Is it worth introducing this syscall which otherwise has no use on other arches
and x86 (and x86 kernel) has already taken steps to match trap delivery latency with
syscall latency would have similar cost?

Did you do any study of this on FRED enabled x86 CPUs?

[1] - https://www.intel.com/content/www/us/en/content-details/780121/flexible-return-and-event-delivery-fred-specification.html
[2] - https://docs.kernel.org/arch/x86/x86_64/fred.html

>
>The speed up depends on instruction type that uprobe is installed
>and depends on specific HW type, please check patch 1 for details.
>
