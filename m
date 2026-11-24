Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530895;
	b=F+hpf0Up7agMOxkPM/Y9kbPQUfXNLau6xOlvRSC9co9EsO0gfIJ8wKSUYWhXMBrqKwD9
	 Q42+w1nme7bg5gyDzuNHkVSqdpzyt/Qw6Pe/qMfO9o5cD9FceXt97CPjQO0maJW7gPsdB
	 mBk5rNWbf60oUwjac3wDVO8ZLe9KPPMbfVbIB9W8IrZOXE9w4UhjcZ2+QAKgj5mhrJXvy
	 /ai/kuLbveGIGqURujhecPuqcrp4r72nrV3SMy7B65M0ibOk3nHy2jvR8Wg2/gONgqycI
	 lZ74kjRzrEVfEP6y11huL9ql2VyJ1DxIZngz3Np62/JLJn6n+Q/W7+GwAcyqrlfUKag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530895;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=/CT6/MyjBFCAt30ylmwkm5YqXIvvm+uNz1QIn+PjSwk=;
	b=hZI68cN8ArNpXYZfXKdh70uBCGOVqDCNfXHvof6ghDEOz8JBVeY2gDZoHbjChXt+nCA7
	 18/MzWSf6JXYSw76MjWEJH/9yw4LMQBlV1NF7JxUlcigGYPUr05tFtMvjJaQmJbdq8Rb/
	 l7X8mX/NEbOy596nvs2wQyWf79L3ez7I46mGS+Av8Rjl8vt44prGxtA6uzHlsqlxVhMA4
	 I5vxtYdSzh7WMGuCfrmItLx/kgLHbavE+VryqLmkv+nfX0Msy9k+hFgqKY91OFAOtkhRq
	 y3h06Ugd6LuqjBmd7uOg+FSR5wgIuuHVDtKV0tjwcw79HtzyQfdKMaJs8PBRIR9SvLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=joj9FSb7;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95C606A685;
	Tue, 24 Nov 2026 14:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD95C606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=joj9FSb7
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 73CD8C0B9D;
	Tue, 24 Nov 2026 14:34:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id A3D5F17;
	Tue, 24 Nov 2026 14:34:51 +0000 (UTC)
Date: Tue, 24 Nov 2026 09:34:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH] fgraph: Format error pointers as signed errno values
Message-ID: <20261124093450.555bafa5@gandalf.local.home>
In-Reply-To: <CAErzpmtcDUu6dtQAvV4fJTuDyr6YqtyrLi6XBjWHLjxS55RTYQ@mail.gmail.com>
References: <20261020104710.2366146-1-dolinux.peng@gmail.com>
	<CAErzpmtcDUu6dtQAvV4fJTuDyr6YqtyrLi6XBjWHLjxS55RTYQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A3D5F17
X-Stat-Signature: 4aaqgt1kon5yofrsrk3m38c41yhdjsrf
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+XPnsBSjISZXrW6/affoj0qDxQzPO1Cno=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=/CT6/MyjBFCAt30ylmwkm5YqXIvvm+uNz1QIn+PjSwk=; b=joj9FSb7fNf58VcbWIKo3NQFWC8XZdKBGEEUT5v6jQ86d6Pv29zqJmPHkb4E9JPIdC9d47R0OjrE64QdZ/5FOc4z+Tp3yjPvlPMDL0qplOaB/+lxNL6sGAbUxVFcrQONt7EE7GfrSLdxkKhBvvVSRcdMP9vChz3zeYMUWxZeOqQ=
X-HE-Tag: 1795530891-558170
X-HE-Meta: U2FsdGVkX1+91AO1C8lgBAF7jFZzqoKSsDJx768XTKRRNQg9ajXNB3MkTqyhrt6hMPuy0oaBBv3i7gQ/73RM2pjbgGokX5gjTNi9k8nnboO/9FUB7TRz2ZxFX+yNXQ11KYP62K8RDlUMkvXtFfnZVFc0M643ZVNGBvdDUdSGl5cjFJECVnR0aHaGMm2Udmu0g1RUZ8mFpLPUU/NLIDDXlrSX3ntG+2dW9uKJ58ZqYS7KuZ79AOAZ00CFGZR3UqI0azSl4dl3kJ2z7AQMZoCe7f1jlVBIj+grVYTAFWuOdhDOtCA4GDYWA0HHA2QfBPkhSweJr2u31Zj3nH+1MXKiamz/GEEtGnxP

On Tue, 24 Nov 2026 19:07:55 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> Just a quick ping on this patch.
> 

It's in queue. I have 153 patches in my todo list and unfortunately, fixes
always preempt enhancements. This patch is more of an enhancement than a
fix. But I'll get to it.

-- Steve
