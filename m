Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302737;
	b=stlUMihB9hbgoGBwqI3PRbMchOzP6b0E8LbFsSSHYQ2cEIGbbDWc3DlqSB3hQ0B9Zba6
	 KIRAns+SeYqmysNZKcKiVc3fZsVv55W/YqACejw72hVb4hTPZ4/ZtAftFUS6EeUHZP+Cj
	 Shs9LSIu6uJtLZFpHUVxqNDC4usv3TRUp4kbiZFrl7sZY4z8+RTyR3gUslenFkbjl3MZQ
	 fCH5ChpclUiVcYR0xWY22lPYsZ7XQKAXGtBclp/EHuZOLOsJQU6qRjAijKDunGLIhtEbc
	 iZhxAjAfHspLVPhjKubB49ye+fDMXpoKABIR5/QYJlV+RcLcWVl9uBznvSz60wCQjjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302737;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=vPSsXX3clm/mdMUjS8oLuvG1pE7EzVDHGhOmLvNaAtU=;
	b=Tc5U3poZ6Ibqsrb1WeqygC+ilRgllfs2IBPU09nNTLnUGRDUUNgZwg4WL04Gk+YtbJFy
	 BS7IwXi+M49FxZPs7FLhUyZAhJLjo5nCX9Oe1FktdafWQdGvZVX2oqFIVficB6dkfA+Yn
	 4ZsGPethZoxSfp+cp/vrRklJHNT/sk7GZpOGo1HjmieXifeTMTCATNhQVd96/aN5FmRyX
	 6802e0yP+v3MvY9+5qDRBjmHoKcsELADA9AmQX+LJDqAuN1ZFdP4Rmcth236pcZX2+sT/
	 QUkWqLX6PuAEtnFuMX98tDd8I+JOPvqVCs4Y8TjaQcRG+B1jcI5K8s1wNJpjDDh714A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=FbcDXnzp;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22C6606B2D4;
	Tue, 10 Nov 2026 09:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F22C6606B2D4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=FbcDXnzp
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9575440191;
	Tue, 10 Nov 2026 09:25:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 146FF2E;
	Tue, 10 Nov 2026 09:25:23 +0000 (UTC)
Date: Tue, 10 Nov 2026 04:25:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Vincent Donnefort <vdonnefort@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring-buffer: Do not WARN when trace_rb_cpu_prepare()
 fails to allocate
Message-ID: <20261110042517.5bbbe14b@fedora>
In-Reply-To: <CAPDkpGre=z=RCS_ffBKTKV_GsQn4ejyknVwNPFmjkhGTORZy5g@mail.gmail.com>
References: <20261104222558.863948-1-christian.aurichzm@gmail.com>
	<avGSispr9aIXliex@google.com>
	<CAPDkpGre=z=RCS_ffBKTKV_GsQn4ejyknVwNPFmjkhGTORZy5g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Stat-Signature: 9cdzj5on41zqzw39w959yjezp7g6u3ia
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 146FF2E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX187wsdH8oh+6xuK2PV1vt+uxhnL1R8CEvs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=vPSsXX3clm/mdMUjS8oLuvG1pE7EzVDHGhOmLvNaAtU=; b=FbcDXnzpaSHtj+6exOFekjDJNbD3p6MBpCcE12uFldOKHBf2rmLxfO9h+1m2I/HLpThzw0PV8L7S5BzndO4DHoNaSCfqe4zlLMUvRBHUJEQ9ezYdP5R9LD5Kq8HB/WlePPrtfwxZGjEiAylz1mz6BZys502TAGV8Vr8SXPXZ8yM=
X-HE-Tag: 1794302723-842149
X-HE-Meta: U2FsdGVkX1+W2o1P2LoZzKBiXtxhVFjpiDOmOZ1Z0AN5VCIPlr+ssGha9J/Uz03ymgIjZI7UUd0v1Pzj8QXy0GWj/aKvNio102pZb4yeC+e+VB7WJTM+dnQDAo2LGsnMRsfpMfFEFX99vAI4GAn3gNZMtHUliino2I5Sk/8tio0HuIptkiFBQ/BOpgJ4xjwlD/g0drxO9RxEqc+Kc56TCoV+j5DOik86vdzkLgG3tdpUpwIVIkrh5xlgRZSJJzeOBPGDQM/l/MWMKTBlDSgw0T8O5+EvcyWTY1V5zhHkPKgmnpSoXvXHMRjtBqWXY9qekx7HwEpWa96jXmJ3p06/QM1OaM8P09CfnxEgTIrhlSB+QtRu6GovCw==

On Mon, 9 Nov 2026 07:38:55 -0300
Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com> wrote:

> Thanks Vincent. I took that reply as Steven explaining where the warning
> comes from, but I may have misread it.
> 
> Steven, the same si_mem_available() check fails silently for the current
> CPU in alloc_buffer(), so whether mkdir WARNs or just returns -ENOMEM
> depends on which CPU runs out first. If you'd rather keep the WARN I'll
> drop this.

Actually, because of the CPU coming on line (not the instances) I
pulled it into my test queue. I'm currently traveling so I haven't
pushed things up yet. But patchwork has updated the status[1] of this to
"Under review" which means it's in the testing process.

-- Steve

[1] https://patchwork.kernel.org/m/20261104222558.863948-1-christian.aurichzm@gmail.com/
