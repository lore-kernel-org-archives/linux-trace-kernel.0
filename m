Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.247
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190995;
	b=PreCe95Zd+UcEiPldqOKGNvvFXVbmKL6aXcoNaWqkTM6kUIJDQ4bxDEq1xly7Xq9eUcr
	 kxPv25WOzEArIlpw2pVwbWa5S37wTEpyS7Zhofg9ddcCXf3HKTjtnWzbqr0fyaKtc2aof
	 nKvZv5Cu9qLXprazGU5y/NX3NKLubpN8mT/21gLaOvnHUNWDyWn2olREpCVhB1ARjkPcy
	 BBGlXLqwy6qpyQQgR+xV9Uor8fVYu72QUb/jqM0rGQ4K0vFJ5zM8newSJH5JKpYPnzzDm
	 Kv3HJi1E9nNV6ghWZak4VpSMeo+LiBOXFTiTksjwDOzL1cfEhkbhRcHBVmUADAhigzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190995;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=616SavEERcf0wLBB3MtaB5Vjvy14ra3RY8LHIRO6Zwc=;
	b=bi180/wIcJlJWBL3CBKaEieO+uxO2FAyH5jrZESbfMAN2Y2XlT/Cu00HGyOd/jOG8JNo
	 4lrR0m4tSuhIuoTrjuSlLc72LudQ/PvFH+k7NY2LiNCk+dHHsU3L3Hw10CpSgoKg4WKGr
	 G/vRTLzNXbvnPMb/1iRJU0IT9Fy226gCeZR/BWfGmVfgc1OIp44qPW/+JPUTmKPsXQmVg
	 ULAh1jyaKp0AYNBL3tWZJ/A0IaaiCTP+L3wGzWhJ7jpznw5oDBOQKaPKpYrHAmCjGcgct
	 AH0pyt6vr+M3FAkSsNdYoRSmWw8ntXUNCRbcF+A9uiDo5TbgSr2OgItfgZHDlEqY9VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xM+kWndo;
	arc=none smtp.remote-ip=91.218.175.247
Received: from mta0.migadu.com (out-247.mta0.migadu.com [91.218.175.247])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF13606A321
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 02:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADF13606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xM+kWndo
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5wreqCYW4ZBo70/LRl2EgOAhGbY7eNZsCbsiZu1vgfk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794190992; v=1; x=1794795792;
 b=xM+kWndod1z2Bk3XjnVdMLp7WfWv/br1i8Ab2oUCjf2uJ10UFHT0jXjkFUcieB/z36P9nh8f
 EY0OQT+rLkczRKQh8G8tHQLu8biBduodhBkSLvu5uScRcaV1uSp+dY0nrtc1OhsTs5w7F2FZ5Et
 rvlnCT1TQzueZEZrI3pi5k7s=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 68f29b38e50f4bf4;
	Mon, 09 Nov 2026 02:23:12 +0000
X-Mizu-Trace-ID: 68f29b38e50f4bf4
X-Migadu-Flow: FLOW_OUT
Message-ID: <91c8d6b5-9496-4c0f-b81d-ac31fbe2748d@linux.dev>
Date: Mon, 9 Nov 2026 10:22:59 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] blktrace: require CAP_SYS_ADMIN for the BLKTRACE ioctls
To: sashiko-reviews@lists.linux.dev
References: <20261106142852.3233950-1-cui.tao@linux.dev>
 <sashiko-outbox-201597@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <sashiko-outbox-201597@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi，

在 2026/11/6 22:39, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] blktrace: missing CAP_SYS_ADMIN check in sg_ioctl_common()
> --
> 
> commit 8392196724a6f06dfb860d63cf54fba3357cc04e
> Author: Tao Cui <cuitao@kylinos.cn>
> 
> blktrace: require CAP_SYS_ADMIN for the BLKTRACE ioctls
> 
> This commit adds a CAP_SYS_ADMIN capability check to blk_trace_ioctl() to
> restrict block tracing ioctls to privileged users.
> 
>> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
>> index 8cd2520b4c99e..c1bf8ca350fee 100644
>> --- a/kernel/trace/blktrace.c
>> +++ b/kernel/trace/blktrace.c
>> @@ -927,6 +927,9 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
>>  	int ret, start = 0;
>>  	char b[BDEVNAME_SIZE];
>>  
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>>  	switch (cmd) {
>>  	case BLKTRACESETUP2:
>>  		snprintf(b, sizeof(b), "%pg", bdev);
> 
> [Severity: Medium]
> Does checking CAP_SYS_ADMIN only in blk_trace_ioctl() leave the sg
> passthrough path in sg_ioctl_common() ungated?
> 
> drivers/scsi/sg.c:sg_ioctl_common() {
>     ...
> 	case BLKTRACESETUP:
> 		return blk_trace_setup(sdp->device->request_queue, sdp->name,
> 				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
> 				       NULL, p);
> 	case BLKTRACESTART:
> 		return blk_trace_startstop(sdp->device->request_queue, 1);
> 	case BLKTRACESTOP:
> 		return blk_trace_startstop(sdp->device->request_queue, 0);
> 	case BLKTRACETEARDOWN:
> 		return blk_trace_remove(sdp->device->request_queue);
>     ...
> }
> 
> Because sg_ioctl_common() calls blk_trace_setup(), blk_trace_startstop()
> and blk_trace_remove() directly rather than going through
> blk_trace_ioctl(), an unprivileged process with access to an /dev/sg* node
> can still allocate persistent relay buffers and control tracing state on
> the underlying request_queue.
Thanks for catching this.

The sg path is covered by patch 1/7 of the memcg accounting series:
https://lore.kernel.org/all/20261106131829.3228926-2-cui.tao@linux.dev/

Originally these changes were part of a single series.  Since the
blktrace capability check isn't itself a memcg accounting fix, I split
it out into a separate series, but the corresponding sg_ioctl_common()
change remained with the memcg patches.

You're right that the standalone blktrace patch is incomplete by
itself.  I'll fold the sg-side check into the blktrace patch in the
next revision so it is self-contained.

Thanks> 

