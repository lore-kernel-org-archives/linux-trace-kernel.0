Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614584;
	b=oZ/Ccioa/jD9EXLPky2clB6ebJCgcDThimfHXFBrzyhodq2oL4chURPzysbBt9UgVx88
	 MieCLKlK+gnMkuN9/3CybOCkGyPGtXy203zuWOaSo0LWoGkfJSQC+DW6IWiC3eKdjiozp
	 MFdzfFJS0cOgpiZTGGWvbVRXJPY6Ug29A4JsoTnqH153N5vlsZc2N9mrXsOalfzskpoq6
	 ETVxnl1BXsNwz9o84RiVVG1sFXrJ2AH9TRXW9vs7ZEM7jQIgEVN7KGzKIzRoCe+AzvQyk
	 oKYaroaOnf1KOxE2Ff0VrYYbI8jmqvFqZcvn3cNxUhfUjUn01c4/MiCg0Gm5jjPxKAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614584;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=n3Pb3IPG/dL2UGXF0quJ7yGO46jOv45Vh3rUNOrhg5U=;
	b=J4ws4lFsvHE2dH3H5VCP64OqZvJIrVypu0eOZ1VRcDQWxnOpKGhZrkBOX96d9IPUNGhM
	 XPjGq+YQZdRjHgoBRSJ83i80CtEuIbAQ3Hu8U09NAgPDPsIYO+LL5+HqJMkBZt866mAtE
	 camRXH361opuyuuA3fyDd2Zm2JIbJNJnfSbwpEY/2Xaij7+8Zffr8+NmAfqzmTR0/VhVT
	 x/ITS3AVLaPkmFjBq2KUQW8FOAlGLzNHyNc74vJz9CJVuhve3tZJK8ysKe23B0ccyGHNu
	 sc80vS/izIrBeGLa6GLPBcotU69RK//S4wSCqopG6Vx32hzRweb9aBLwuAyIIVGYYlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=e4oHDpaA;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFA606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 13:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70AFA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=e4oHDpaA
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0DD5640F15;
	Wed, 25 Nov 2026 13:49:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 6966C20027;
	Wed, 25 Nov 2026 13:49:40 +0000 (UTC)
Date: Wed, 25 Nov 2026 08:49:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Crystal Wood <crwood@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 02/10] tracing/osnoise: start_kthread: Always check
 OSN_WORKLOAD
Message-ID: <20261125084939.1a40eabb@gandalf.local.home>
In-Reply-To: <20261113064103.3041704-3-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
	<20261113064103.3041704-3-crwood@redhat.com>
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
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6966C20027
X-Stat-Signature: acx3kxstxzdzhh56u7e4ej6gijja1adb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/m/dqVLCR7N9nGuXZgTfdNiiJmcEPbmQs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=n3Pb3IPG/dL2UGXF0quJ7yGO46jOv45Vh3rUNOrhg5U=; b=e4oHDpaAGZjZhvSAdnpoXolyhYSUVA43YccsZQ14MeywzZIR3C0480tjYH70V9NGo0efL+LArqix7iNkWxMfSbTRyXX0ofhRT8nYjW+XPtzGpn97MbBsxcYDYPFxKFHHqcMSM/g7wX1lc3mbvdLwfZzG3dRZpIpegcN81IIVv7I=
X-HE-Tag: 1795614580-215117
X-HE-Meta: U2FsdGVkX1/Caesr92iVpyhxEuGNlkXw0Bva/iO2vaDnYZXjSq44YGCcWxdw6HKN9AsQ1EOPOWmJ/V1zaQliiEkF2KqZbVbGVu+1MHMP/csWNmV0srl8cG3ADwno0wfiEUfrCdYcuBZYPj3lCxDGIi5rZEw/BBkoTc2qsFCeEHcPrNzamg1SxhbqNEy4KquDXjf3XlhkMHZIgt8Troa4sdqTlhcVMGB8izaYzFjV6sygJ7nJzYiMMJL1BRtrRlzP0My+4ZnpXDutsaPttlD9LWJesypLKc7hOVXGw5N8nBWjrEFuZNn2kih66vrmOV2kCuyAliZcGzJnnWnnydbkHdzDi1hS+uUQ

On Fri, 13 Nov 2026 00:40:55 -0600
Crystal Wood <crwood@redhat.com> wrote:

> We can get here on timerlat with OSN_WORKLOAD cleared via
> osnoise_hotplug_workfn().
> 
> While we're moving this code, remove the pointless compiler barrier
> immediately before returning from a function.  Even if it's inlined,
> it's not doing anything useful.
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>

Hi Crystal,

This conflicts with the fix I pushed to rc4:

  5f85541055456 ("tracing/osnoise: Don't start a kthread in timerlat user-space mode")

If there's an issue with that fix let me know.

For now, I'm skipping this patch.

-- Steve
