Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51542D5937
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Jul 2026 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096232; cv=none; b=LLKR9Wj+W4rqprGypT7UVqOmO8gAB2Qo575JGntOee0JIxUXacOxmIddPqQUFgmG67WHLYdE4DERRPBGFf4REV8E9MUUV32Al7IWfmaJvMzfn3PSrEXKZQ9fh5k8TIxtJC+R9pswZbvCVV1gyrgzza2rvczHEElAwNuDQjc9qKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096232; c=relaxed/simple;
	bh=0CRYoHs8wvBuD03IsbtP2Ve9yh2Pqll95uV9IxaOdkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=RqYDO/3pqtOv9mbUmke0i4JEaVbvJKb4v4CDtBZq6BMz4lidwDOOGwv4pLffFXvJZvF67XwUQRAAtdlYMNwJ2+gwCwWdC7zGCzZBlwMgdC11cMoz8zkgbjKU/x8Ow9hrt7hfuKlR90wR0qKbkkvXHRr6U6d6Z3f2Jsyzyi/Xdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VDn7A6H5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDn7A6H5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783096229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3gLsJtFn7ODOWcrCk2NOJF+bI1kcWS9SdZ5UbnYHxbw=;
	b=VDn7A6H5/el2wvV1pO/r2nO6N4WFvK4lsmBfJlyUpta4r6fwEYqByfw4GMjqo3Y49i8LKs
	kXbHfwTgg0ZWR8KiS0hOQHWo1JTfLrO38x00sTibxetH/x0t1zw493JO3NQkKqJHRqXwu6
	EAbYZUFq7A06RRp3dYzLPgAmxvQ9pHI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-SpeF33BxMLiQ5-iPZ0QsyA-1; Fri,
 03 Jul 2026 12:30:24 -0400
X-MC-Unique: SpeF33BxMLiQ5-iPZ0QsyA-1
X-Mimecast-MFC-AGG-ID: SpeF33BxMLiQ5-iPZ0QsyA_1783096223
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FDE619772D5;
	Fri,  3 Jul 2026 16:30:22 +0000 (UTC)
Received: from fedora (unknown [10.44.32.112])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D073C1971E7E;
	Fri,  3 Jul 2026 16:30:16 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  3 Jul 2026 18:30:21 +0200 (CEST)
Date: Fri, 3 Jul 2026 18:30:15 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+0255c92c72505dcacba6@syzkaller.appspotmail.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, mhiramat@kernel.org, mingo@redhat.com,
	peterz@infradead.org, syzkaller-bugs@googlegroups.com,
	tglx@kernel.org, x86@kernel.org
Subject: Re: [syzbot] [trace?] [usb?] general protection fault in mas_start
 (2)
Message-ID: <akfjlzQoBFW9qnGp@redhat.com>
References: <6a47dd16.6912059f.e0473.000e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a47dd16.6912059f.e0473.000e.GAE@google.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Zjck10VsgsX0OTC77eeXDfTrXHyjx8PLC_N6HF1AvyI_1783096223
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 07/03, syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    dc59e4fea9d8 Linux 7.2-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12610e1c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3c3d59be33cf7e9a
> dashboard link: https://syzkaller.appspot.com/bug?extid=0255c92c72505dcacba6
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143f8261580000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-dc59e4fe.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9ee1f0ea24f2/vmlinux-dc59e4fe.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/729e963a1370/bzImage-dc59e4fe.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0255c92c72505dcacba6@syzkaller.appspotmail.com

...

> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report

#syz dup: [syzbot] [trace?] general protection fault in mtree_load

Oleg.

