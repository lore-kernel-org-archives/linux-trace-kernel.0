Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794029974;
	b=SP+7B/QzWVC53f5xaCxlEHw5seLAInWyh+CL4SdluYSUgjcac/h2gVqLQDtHUhvcqMeG
	 DboVpQhwSIHfu4XdpjwhZCNkJZuNdF/UErx+S631IbCbWuDGGWM7P23gzrzI8sGzNmqdz
	 7sK5XdJM/ozLBBJr9o1bosyLijUBCzZ+qW4tuiUYPQ7nnyyY30eoEP0AzRY4WpZMatziI
	 Acmn9ziZJ5lZgQEsbAFnOBmZYuYL+MoWyd8NdT5kcDSzsmbzrY9KhZHsdp+/pDAdTFIKC
	 hm0a7u+8kTpWivVDuUSs88uHw0oilap6jgAc9vCEpoi9f/KKcHUDQaep21hoAugq9DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794029974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mf4ZlSzQK0A1YfaXfnQYSWywPw9KHcmgJ0Zlx/5jJks=;
	b=dIjOkxYRw8NKaM4C7GTZT4Ri0uKnQUlU51hgc7TvJYf4auF7ORcAyiMJxJ+aMbEUjigw
	 I+O6FohGTYIjwmCAfe56Z95hjMkRVMIZAsg7iAkYy/K5NS5hCaeH7N2uhsgL/sCOI3Ftm
	 C2iMtpU4L3hRFFWbHBq0bEnAzFRI+jGyqrwwZbeID2jrFI4Or9pvQ8V96ON5KQW1SSf6k
	 /TDiETBVQCjeE+EoeXC+ffacNNggin0GLtUTJZWPyEkWfpL3wrQ4xhxE0MwDbAFtF+X2p
	 C1UpMLuroSmMuRYzOx1jOqrNWZQvMGEKRGYqjAJWt3F7LPW5yRWQlsKXWwnKUZts0oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYxxEQoA;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E251606A32C
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 05:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E251606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qYxxEQoA
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so815272a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 21:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794029974; x=1794634774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mf4ZlSzQK0A1YfaXfnQYSWywPw9KHcmgJ0Zlx/5jJks=;
        b=qYxxEQoAgeRTjMwaQDC2fAV485jTtyVXXUh6AN8P3ryYgsUwS7AzrM/L9YOTmUktBL
         GrmxIh+aph7bmf1AxySbrEQwF1kVvNaiFABat9MAI0HWL4TvDQAeVqzgzJuqtoEuw6eQ
         lXAm0ibaN7snVWedEdSBLO15ROieRTahbPsvyOWVseeXVlO35wemXKH3VSUJhQ0Lx4V7
         yrTBrej7U/w/9xOobPcuIsCY53gGXyWvz1TUQHwH3AJNJsnHoe5Esl5h88vkgrjdYMVK
         1usU1L8rLYsy61hnyX/H7fDmdOaYfPzLbXxMCOOAnoSzAfkb1XYCAlLKarUsU5kGF+KS
         +3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794029974; x=1794634774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mf4ZlSzQK0A1YfaXfnQYSWywPw9KHcmgJ0Zlx/5jJks=;
        b=nA5nvrGVQ0VlyPABuf6hEqnREaFjO+0rwBFIPQUdGFTwsGoiTfU4jg8ZJJU5vwtKzu
         1R5eiom0b8U+0Dpg4dRtepnwwe4gFE56VTcnCGrI5xZ9UHlulrN8vu49Ua9GbEzBBJGH
         8XFQzqUzovkQciODAiGv/K9hcFQuj3uALfLTzZYN7U6jag0F7VM/lMVHFU6iyx2hGUEJ
         f/4wVNVCxMh8rgiaFe3+o9wFcBK9kEFLrtemU+o9keR+k7iBGn3d2JskS9AblFQqhuuf
         xDZ/49V3L6tzIrVvCcuEcJ1K6JQhKBnihU/TtguT4+hpWLprbcuXx2Yi6zqoa6ggmPHU
         D/WA==
X-Forwarded-Encrypted: i=1; AL+hErGqAJCtw/u5juh15P7ywDryAVbICrYlDhW+PwMgnyWuqBs2SSqrFkDzd8wpOjj0Fa5COcBkA7w45oAYT7M/EULBt1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ighUhIC6rIi6RBUFYgvqMorZsXmHZaUcZTXVrCDOmSSOnHyPu
	q/Gwo5eFvFtHGYAO6KY2ISypzhquRvqfezhKcyZK3K1L9gGVnEflHxqd
X-Gm-Gg: AYBFou2PkHbcVKWLTfi0X0m7GTGYmai7YI8pfqAxKpYwrxdwpmtK/DUCgPFpSLzrXwg
	XAgvNjQEM7SSYCjruqw8XgphL5fdsuexm9/xhzUYcJwFcYxWtqA31WA57VSaCBJoHOxffpTyKae
	/05QTI1k2Qk2n+cqVZVSLeYHTVJ2MXGxgEoRmtvfR4ES0LdTNTvWSL06gj65V1adlRzU+dXZfej
	n23ytvkgjMIrfiCmqqTncjppTPYEpmxFIUmKp0LXko8NMvBngPsxVn/1BW3zEoa7cYfHydZpNYu
	BT1NPquE/4zDWII0FsG7Q3EZ30ICKyNY46M1QX64KduBRqPPQW02Svc2VOnQtMSBO9QMyy0dM2i
	I7jLDK5D+nPIGhM4h4HSz8LLGrexXgpahgSlSdmPk1b1Bg+82FF3xm8ER9DROqF0XO5m8Ixye8B
	bX68+0yScO5ONpeSjob4bu2zZD3DQW12OjmX39VAJGvt/smui3IudkdtX0gPcEQeQkhdoyp/UFm
	+JTqeqIA1K7YBSfBJXHIu1LLfo717yO2vQW81XFXTSrwTcriZVZGnPG51Obg5/uqBEh3/J/OGUa
	Ry6oLUrKkr1z+MtZPoPoD+rbsMwykiPVzKD7bf9IuZBJ/3/UOh20GC1aCa2aQy9aNMdMfg==
X-Received: by 2002:a17:90b:3950:b0:3b0:92b2:2e74 with SMTP id 98e67ed59e1d1-3b0db6f6c35mr4733562a91.62.1794029973785;
        Fri, 06 Nov 2026 21:39:33 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a1a:7bc2:20ba:a479])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057b17f8sm1838127a91.1.2026.11.06.21.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:39:33 -0800 (PST)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com
Subject: Re: [RFC PATCH v7 02/10] trace: use the stackmap from the ftrace stack recording path
Date: Sat,  7 Nov 2026 13:38:58 +0800
Message-Id: <20261107053858.3070072-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103193421.63f4454a@gandalf.local.home>
References: <20260912083753.3426176-1-lipengfei28@xiaomi.com> <20260912083753.3426176-3-lipengfei28@xiaomi.com> <20261103193421.63f4454a@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

On Tue, 3 Nov 2026 19:34:21 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> FYI, the tracing subsystem requires starting subjects with capital letters:
> 
>   trace: Use the stackmap from the ftrace stack recording path

Will fix for all patches, and use the "tracing:" prefix that the rest of
kernel/trace uses.

> Also, did you use AI for this? Most of the comments are useless, and sound
> like they come from AI.

Yes. I used an AI assistant to help draft a substantial portion of the
code, nearly all of the comments and changelogs, and most of the test
programs. The design decisions are mine, and I checked the test results
and went through every version, but I should have trimmed the comments
myself before sending. Many of them were added in response to automated
review findings rather than to explain the code, and they stayed. I
should also have stated the AI use from the first version.

For v8 I am going through every comment in the series, removing the ones
that only restate the code or the review history, and keeping only what
the code cannot say. v8 carries Assisted-by tags, and the cover letter
says what the assistant was used for.

The rest of your comments on this patch will be in v8: a record_stackmap()
helper with a stub, the depth check before loading the map, a named enum,
the tracefs setup moved into a helper, a stub for
stackmap_mark_init_failed() so the #ifdef goes away, and the comments you
pointed out removed.

Thanks,
Pengfei Li
