Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA79820ADD6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153270; cv=none; b=hllLiylhpPPXZ668p1xVr546DE6dS+QnP/WndkwfheX4cutlCb2tK7WKQ5cGAP7B6PSOhDlri/HYR4/OrwL19I26utB/AvJoQoIsxVjlesXUbX7+YnnZl4gDm6p/NplsnLQhL1WByr8Ayb+dc/qdHAExDstoYvALyCkkeQMpTq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153270; c=relaxed/simple;
	bh=alRvOln8Nm7xlD06ADuHu4fWBMIFmyhc0+nC9Kjtgz0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u092sajrctMJ5Lt13sPNq5N1M+Wj3buVwmBg6lvHx7yzWaJM5oYFZYrTWoGppzMDz4YNvgbHI+GWkl4sywxmbjoQL6c0bisg0znlZs+kmLlHNMGZZdov7y0p2BpN/rSTI9tjjkIx52l+XDEm/o05aymzmFsTGSD3yV64QzOiX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=yYhkhmFO; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="yYhkhmFO"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-940d9772e28so160144639f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761153268; x=1761758068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=02MaJ5QNPtaAAnY4QmtoKQvBiiM3OxRwrbvkWHDbg0A=;
        b=yYhkhmFOGHZ79ceAeRzsTTx0uIufp2jrNynNpQGjS7S+3KCfVr2bpmUpwJYH/OkF+1
         b9mIzOGpiNrIrauCc69AFuJoYt3+qRbNIDK8l/4rRoFv6Cw2ac1uqGl5MnnGe09P1vES
         qv2URYzJ5eGZAYcdCZ65BvMGL1rjbFXYFFKOXkToGWXhxLTr5UoPZAH1+0cQuiacRG60
         tuTcGb5GLXAAeOY2pikrwWIS8Ci5qQOt39KHYEsmsRNtXwZEVoBPhLkvlSgnITJMv7Cy
         58Ai49HfLjqrdEd54yvYAU1xC5SThHzljHjD3mvlCyer8zmZ1zWm+tnAWBVII86K4Ets
         7f5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153268; x=1761758068;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=02MaJ5QNPtaAAnY4QmtoKQvBiiM3OxRwrbvkWHDbg0A=;
        b=U6vKVVn+Qioj8ycUgUJIteK6dwOvn7x03kcj7Sdwq2kJ0lzWrkem1uDxtQEhg+zfz2
         3Qnkp23RQwbLxq/vWUIWYsMQTczRBLuDqmYP1OPF1nmEszHARg7OOQDu73UgRwJt2YDZ
         +4Iidkuau94cUNTYS75QE/qL0U2n+ZbSmAQKaeQSNe7HuB4VH3uclnVQG06uvnYhfKzL
         El1YrRgn/cpkwUD098a68wXx9TVeUSWttaUdEDxUCiElHEGnY/AwmnbljBa9lr07yFDs
         +D7vpqy38DUhEJlt863aeTWsyjLXVq/4bgSmA5GCljAvrIZANiqh3mdxRFm9Xnl8yYL3
         gQOA==
X-Forwarded-Encrypted: i=1; AJvYcCXUVRcSj34vsnpYHLhmRH8OSa46wmum7mAikQu6MqHWG44hHZbzg0h+vHuzsv/NLLzephXLITFSmOpStwKFOit3Gr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfU6A/vKQ2E2I3M1aqBSKnlfPYYJX5QClRHgZA1HhEaUiJf7rk
	WhKRoSXf81wmLg1reeTFx9eNcEsKLRWeYnAxT20iZn11nD+vhs54X3W0+QwCwSLt5OI=
X-Gm-Gg: ASbGncucLv4dF7lo60dB992EXki+sOTi//t3pR0qNvR51WmdE5XtGQU6bJi+seHPSG+
	AniVvjT8lfG8Ht5xwJOImN01b5KFX/6QxDvNRtz6Um36ToIaNfSd1dFl1UK3jROo6rqAzoRnLuH
	RROr/csoN1zwf9W2A+mY+2gxpP5xB2a+J8SjsM12O7r6nNXFLrtcMNxflgzPPraMivJ/pYIfdLs
	DTaE/DQTpoWX3E7/WQ2x//H7kGgbrXsbLnx9gh2B9oN2oj//2M0wIblIkGY/F2E8r6a3XzyjAB/
	UgcLzjWU8BBBUV7byU9D/gLpTK/NuoDnVNH5Ns/NcZV9c/Fovwpa1Bq4bxGudrd8E/l3pGPPMHM
	VBPEHwT8Gu66hnfMM4VPrirdSJjt6mmSOJERl1pWJMjm2KJWut+yEa9AWUDIAZbeC07y5phJFaO
	7Y7A==
X-Google-Smtp-Source: AGHT+IHTj61GCU43Ny9CqJZTcArqcqLG4N55exTJ/CO6XywRSm8cR6B046X/oK+en5lUBxrNojHA2Q==
X-Received: by 2002:a05:6e02:1a66:b0:426:c373:25f5 with SMTP id e9e14a558f8ab-430c527dc0bmr294941715ab.17.1761153267700;
        Wed, 22 Oct 2025 10:14:27 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d07a82ebsm58994535ab.22.2025.10.22.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:14:27 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: chaitanyak@nvidia.com, dlemoal@kernel.org, hare@suse.de, hch@lst.de, 
 john.g.garry@oracle.com, linux-block@vger.kernel.org, 
 linux-btrace@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, martin.petersen@oracle.com, 
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, naohiro.aota@wdc.com, 
 rostedt@goodmis.org, shinichiro.kawasaki@wdc.com
In-Reply-To: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
References: <20251022114115.213865-1-johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v5 00/16] block: add blktrace support for zoned block
 devies
Message-Id: <176115326663.119946.495631617143867642.b4-ty@kernel.dk>
Date: Wed, 22 Oct 2025 11:14:26 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 22 Oct 2025 13:40:59 +0200, Johannes Thumshirn wrote:
> This patch series extends the kernel blktrace infrastructure to support
> tracing zoned block device commands. Zoned block devices (e.g., ZAC/ZBC and
> ZNS) introduce command types such as zone open, close, reset, finish, and zone
> append. These are currently not visible in blktrace, making it difficult to
> debug and analyze I/O workloads on zoned devices.
> 
> The patches in this series utilize the new trace points for these zone
> management operations, and propagate the necessary context to the blktrace
> logging path. These additions are designed to be backward-compatible, and are
> only active when zoned devices are in use.
> 
> [...]

Applied, thanks!

[01/16] blktrace: only calculate trace length once
        commit: a65988a0ad047dbdb8a1eb6f07540b980858b522
[02/16] blktrace: factor out recording a blktrace event
        commit: 472eca538358fc8a56884a8adb0cc6047bf05cf3
[03/16] blktrace: split out relaying a blktrace event
        commit: 04678e72e95f4165d58442b3ed108e06605984df
[04/16] blktrace: untangle if/else sequence in __blk_add_trace
        commit: 70e3c62b891281b94b9d449a381e033ce592acc8
[05/16] blktrace: change the internal action to 64bit
        commit: 370cd70a402f972f6d7a7e54ba5a82d1a72c762f
[06/16] blktrace: split do_blk_trace_setup into two functions
        commit: 42da88a724d8a3b92ade35ae2ef4d5e5a491df2d
[07/16] blktrace: add definitions for blk_user_trace_setup2
        commit: 0d8627cc936de8ea04f3cc1e6921c63fb72cc199
[08/16] blktrace: pass blk_user_trace2 to setup functions
        commit: 113cbd62824afdf62d2f3f092809cf37cc7f1dd8
[09/16] blktrace: add definitions for struct blk_io_trace2
        commit: c44347d606260f36a81f6d8415a5af33cb3015fa
[10/16] blktrace: differentiate between blk_io_trace versions
        commit: 915bb53860c3a6cc3dd2c9a5e0d1988ada0e377d
[11/16] blktrace: move trace_note to blk_io_trace2
        commit: 67bfa74d81bae9271f6ec72d2058d081732949cb
[12/16] blktrace: move ftrace blk_io_tracer to blk_io_trace2
        commit: 4d8bc7bd4f73c6b34ba29d3e8277864c6e0a44a7
[13/16] blktrace: add block trace commands for zone operations
        commit: f9ee38bbf70fb20584625849a253c8652176fa66
[14/16] blktrace: expose ZONE APPEND completions to blktrace
        commit: 1c164fcc1b08e75f1cad1532718f09cddc0ddebe
[15/16] blktrace: trace zone write plugging operations
        commit: 3f6722816a73e2017599d965683dbe71833afd7a
[16/16] blktrace: handle BLKTRACESETUP2 ioctl
        commit: 4ae8efb4f907383a16abf3c59b353763e31ae106

Best regards,
-- 
Jens Axboe



