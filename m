Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7A24633C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794887; cv=none; b=bSb4REupZAc2Xy0Z6nAV8rJWw2qXhzZF6mxfVGdrQGafJEh+sK5yQARY0BConnrCU71bNd2PsnDpi6c9m8tqyuZLgtpxJkFkgshsW6bN7PGkaVgbVbEvqFawb8IjvxGXVcuW2dck/DUXIuD3vQ8MHp0v6MHLerwCB48KSR+Y6pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794887; c=relaxed/simple;
	bh=iAu/m/Ked4Yjj7vjRUJ1EMyr8TIJsgKEj/d7vMIV89w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZ//EzssOqXSvyK+JhyBUHy5du2uRa+3d5qPKQOMg81T6nx9N2Oh9EjH0bRvlc2Iz+CqA5UFl0Ng9ZzQua368vGp6989us9ysXTOyq3Wvz9bclzxpy+p36hTe7fnIwasUhqvIZxhlQP251+5k9g7R4NyamPReGvaMGqmWCrpV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e2I/Zxow; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e2I/Zxow"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3122368d7cfso1192672a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752794885; x=1753399685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CqGazWb6yxiRvzTGHHODvUW9Q9sXD371hPyILW32ck=;
        b=e2I/ZxowhVOdfWe4Qr1QfQT1dNLuEcu9Do3YtjLtn3E9MYzOkKwFFuOg9qtC6GGZZF
         T/pNRCyqYmxvroJoDEvMsk1eMtppLJh+PjmAX7G6PP6Uy2jyoc52eBNmiLuOrS/OKCg7
         RwNJfvs5nnGXWfnsLX0I57ghxJlqHmX1AbiSWCq+Lg+UTB7bFWVt3gzGDnPxd09T6R99
         MGnruGj/Q946wZqYEV1DB8yK18LLPp1/85QnRo8V1wEjnvpaaVryvGQ7V3SCy5jNffmA
         Y3Y2iLxmfiWUneLZRES1p3sysdcNci8Kta9lyNtuGooeWgxCHmJ/AXVs6M5yAmUTq1Uc
         Nncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752794885; x=1753399685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CqGazWb6yxiRvzTGHHODvUW9Q9sXD371hPyILW32ck=;
        b=e6FTUKebVZ+7GR9XX0y6sT7Pxd4oFyl891xAq6MRlgWAIB6fRWUaaBtMTWjSqmC7ag
         k47hoYLBsV9ijHRX2sHb2+GWCZMmTNnk/cx0dK9f2l6qXHiCcvTI8zAY0en26xDxo3YE
         1qPBYPhJPz3bx68ofYt0Hn6+gvUblerA/0YLNjtpf4L/nor2z24tf1YMzctvg/Rtu9eN
         U+YO9Akgfr6gMpNq2JD8ZbFkqhHHskj7TmqKSU8Jf/vCS+d5KJomqGfwwGu7lkRIqfSi
         lNqbJDs6eFuvdwpxB9DrJiwNptgdSfxWnxmRTiioydox3avwfopxzyLRpT0vOx2n3E5T
         +ZRQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1hgJI3NT3rq/l2Du/Kl6lbaforUoJ014gD8RgCdYdmdICCz/uJle1+XD1kzQL5HDspQhcAIclhl1jBw4d+0jbR+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx25t0cX08jVxiODeZ1bKpTkpsW4ucbLM2ywR422ChmtdcR+lC
	hvMD451gPkZw21CUL2Fr9WLGaTGaWTPVaObYXFvSIVj0ZNo6gqkbcB7EKQxLKiOPu5k=
X-Gm-Gg: ASbGncv5AdFVgiu84iI6V8iUfEOjea7HkAupsGquXOnnz4BvGg3va8pVhnVL0TIDsAq
	goCq/tp/AF/f50xL9PNmsUIEHkN1X6awWAMNtnQy/nomyB/t9bCEZaoZ0QfTbQ0gyh1qPT4mcjX
	nHRDRPaVTRhJsEyk1fjztsGw94SLXbTGhX2tMzEdg7nuzuvvmh4gXtyvfMM3/e2bSlsXEr3NEbA
	OQ6XMq920/ZS9b8EHdFaOZbT9JVlzTqW0VY4XucbgYP8Uk8OkgX05Xw2HWUAaO1br+ju+iBenOC
	ql/q/xweKjl5BSL9AhtcDia3DjYgj3N+rBbJuZNs4bpzK6n2H9ofyOeKnPNRbxdeS0MBo3sJVYr
	zlGJvCN1tAxTcmpmOj1WJt/7lHbeW2UcShmsMlDW7PMcMN64gEik/P81ufDg=
X-Google-Smtp-Source: AGHT+IE2fvU0LI5VyMAsBnS6jAOFpIF2Ch7bsj27Ceh44Xb5VQmNCAIyLSIUVF1pWxqlVk2eBTBkQw==
X-Received: by 2002:a17:90b:5105:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-31cc2544404mr1063803a91.12.1752794885293;
        Thu, 17 Jul 2025 16:28:05 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-31cc3d5e765sm101318a91.0.2025.07.17.16.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:28:04 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: lukas@wunner.de
Cc: anil.s.keshavamurthy@intel.com,
	bhelgaas@google.com,
	bp@alien8.de,
	davem@davemloft.net,
	helgaas@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	mattc@purestorage.com,
	mhiramat@kernel.org,
	naveen@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tianruidong@linux.alibaba.com,
	tony.luck@intel.com,
	xueshuai@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug event
Date: Thu, 17 Jul 2025 17:27:58 -0600
Message-ID: <20250717232758.24605-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <aHlbtTxO7mR9XfGX@wunner.de>
References: <aHlbtTxO7mR9XfGX@wunner.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Jul 2025, Bjorn Helgaas wrote:
> - slot_name() (which I think comes from make_slot_name(); would you
>   want something else?)

afaik it ends up coming from the Slot Cap Register "Physical Slot Number" bits.
I brought up the slot to just say that I was happy to see it & that it is useful
for our purposes & why.

On Thu, 17 Jul 2025, Lukas Wunner wrote:
>> and IIUC, it would be helpful for you to add:
>> 
>>   - DSP Vendor/Device ID (the Root Port or Switch Downstream Port,
>>     which is relatively static, so seems less useful to me than the
>>     USP/EP would be)
>
> Right, this is already logged in dmesg upon enumeration of the hotplug port,
> as well as available via lspci.

I also agree that the DSP Vendor/Device ID is less useful.

>>   - USP/EP Vendor/Device ID
>
> There's no 1:1 relation between link or presence events on the one hand,
> and enumeration of hotplugged components on the other hand:  The link
> may go up but the kernel may fail to enumerate the component, e.g. because
> it was yanked before it could be enumerated, or because the kernel has run
> out of MMIO space or bus numbers.
> 
> Hence this would have to be logged through a separate tracepoint in
> pciehp_configure_device(), not by changing the tracepoints added here.

Ok I think its reasonable to use a separate tracepoint that would have more
information about the EP.

