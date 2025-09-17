Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3E72DA756;
	Wed, 17 Sep 2025 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118056; cv=none; b=BUD+1Zk+PBNr6Y11Tr0EmKnRmIAnsves0tD56MIwTQyzHdiMl6oiBQSfk/6tfv3IF/rsyOfH694XJNYs7DVkAgjEb5BG/NGM/6TOopx/Zh+nE/BMNAoxYbMVhJ1CFR19L6VB3T3HEmiTZhLO1oGzFI5oKM6e1RGLct/WGdsdu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118056; c=relaxed/simple;
	bh=m2pKt/ymqvqobJmR3ZiAxV+TWRlvODP62Gi843uPjm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=roNaAP5L0BOVilsk1NWVRbhfM2+m7ByAB7YdwUbMrhMoXCkYz5kHHHbaLVmBGj8Ru3TWQVi4xxPSX+/+W+fWvZ1tgzppBSgHZSB4Bxzynn90LGJBZfXNa20xrzLh868Whs5bSlHwQgQKBxVGQh2F8LMK1oQLlGT2byh3i73o84c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZVQcLEE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y4ZcVdux; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZVQcLEE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y4ZcVdux"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758118053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4eYxqPW/RTKw76zOoPo67Ia8HYCFz046WwisbxEWDM=;
	b=MZVQcLEE9Um2P9Kd1FSTIU5+F0l5pHPDx0qXVNHFk6c4ufFXW5uUkJh7Pxg41Ees1C4wD2
	AP/o7BybqQAnwiIulL/EWPU0z6lXCU8YlHMkR+7Sj8CLSUvcQDOiCkfPf8auBPdBu6NeTd
	Jusrztepx2BbQM0QMzdIyusOTN3DpXD4Y0B/A0PEPgyg/6QIQ0RIl8f7KF9jhUKzbCM5D4
	eYPmz+vK4JtcswJp5QSp1Ob92aA/IzGjAU3W1cRBzytn2UUgR4hDWpX/GsJGM9Zt2fSK9h
	ZaeDfdj0ziIxv2mfFR0TF2TdlqCp8UFpQ6xe7TOWl5+NOM11G9nxiA1NY6o3nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758118053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L4eYxqPW/RTKw76zOoPo67Ia8HYCFz046WwisbxEWDM=;
	b=Y4ZcVduxRnJAJJKKWIrc3Upg4CFpz8ThC1g6j5fu+b+1DWEsEHDJlM4EhJ7jaxJlH97nwq
	J5le2MuXPjSg/CCg==
To: Gabriele Monaco <gmonaco@redhat.com>, Xiu Jianfeng
 <xiujianfeng@huaweicloud.com>, rostedt@goodmis.org, mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
Subject: Re: [PATCH] rv: Fix boot failure when kernel lockdown is active
In-Reply-To: <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
References: <20250917125733.2346923-1-xiujianfeng@huaweicloud.com>
 <b2c19df4c5036e956e4e892ac983d5488a8b9614.camel@redhat.com>
Date: Wed, 17 Sep 2025 16:07:32 +0200
Message-ID: <87wm5x18bf.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> On Wed, 2025-09-17 at 12:57 +0000, Xiu Jianfeng wrote:
>> From: Xiu Jianfeng <xiujianfeng@huawei.com>
>> 
>> When booting kernel with lockdown=confidentiality parameter, the
>> system
>> will hang at rv_register_reactor() due to waiting for
>> rv_interface_lock,
>> as shown in the following log,
>> 
>
> Thanks for finding this, the problem was already fixed in [1], which is
> on its way to getting merged.
>
> [1] -
> https://lore.kernel.org/all/20250903065112.1878330-1-zhen.ni@easystack.cn

Yeah, but it is interesting that this is causing real boot problem. I
thought that commit merely fixes a theoretical bug. I guess this is an
even stronger motivation to use lock guards.

Nam
