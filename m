Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480375;
	b=vLLCAhSo0WBBoQYS119rqklThdcsDJnS0L6GOPWUsxlXinicfBX/drCfmWSLhhQZjQ0I
	 jx6H53vz2pnCsg0Uzk8apgQxEiUs2/HLX+Ri3OoWB+QM49XzjyauzdvcdHL8QxheITfri
	 Q4zLE9633TJsu45fPJBpBtfzZEVPXh0CEZLqfR+hb1X4NkcnJe0CrtA9wTQPm0pZ5Ut8d
	 6YZcxEgbwXw+eVgFuE6S04CWHH/g9VA3gdq+jjd6SEoSec09SwfFwmVf5o+81stN4L4Xs
	 uyoct5nk09FtnGieHCk9SdhVolRDgesrmYzzsnRM7R+MkMltf9sULxldGWAHwziF3bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480375;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=4jX3n0IQNsJJSebGl5jsOUkEUs41MB88RY8wsSX2rZ8=;
	b=t1kYpbC4dee/ZBkwHtSDsX3ipl1rtvUvH6Mm0waVpa7lhJAF7kUsBzj+dGEsQBhrpJEM
	 kuZV52qEFkxHd27VoSpMp/nEUPS/tZfG73Q3Bylwz5XS5aoyTxi8u8xv+L3MSbgolksDN
	 2xXTjm91b2tkDqVcnibROEym0giIp4mvX28uiA/xglQFsPW3LFXLPeuaNvU/GPT5V7hDW
	 6VOnZhZFudU08UVyyp5eFMHvAmEXpNBNRmXodC0ksc/S8jLraTlBVp3yj+Y4mocFKx6A6
	 38S/FNk6ZTBz81oB6myuRGsjqmpcLkR+Z3O4FRdX6Ahl12dRi3qeDzUapj3IVN8rLqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Lt57riGj;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9311606A32A;
	Thu, 12 Nov 2026 10:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9311606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Lt57riGj
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1D54BC052E;
	Thu, 12 Nov 2026 10:46:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 6234F18;
	Thu, 12 Nov 2026 10:45:57 +0000 (UTC)
Date: Thu, 12 Nov 2026 05:45:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: vdonnefort@google.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+53ab168fdda7fba508ba@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring-buffer: Mark concurrent accesses to waiter flags
Message-ID: <20261112054542.63b29e3d@fedora>
In-Reply-To: <20261111084137.80941-1-zhujun2@cmss.chinamobile.com>
References: <20261111084137.80941-1-zhujun2@cmss.chinamobile.com>
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
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 6234F18
X-Stat-Signature: hk6uimtb77artkm8irgdw7r6jydi5o5d
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18/nl8pFVqTmrcJK8eLcjmxGhEeLuHz1Wg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=4jX3n0IQNsJJSebGl5jsOUkEUs41MB88RY8wsSX2rZ8=; b=Lt57riGjbO+Psp+UTt4upS26k3EFr3HFO1wdYtg4nHDOgK3ES+fYITRLYfSOJovRIFfbrb1sGSA9ATjQzE+XXonEXZtka90YsmuTNJpHkRgd4obu0diFAzAw/ZAO0Fa8oApLUa88bcx+jgHy4u8ykS5Ahe9dWXJx1usnV9L9zHw=
X-HE-Tag: 1794480357-426971
X-HE-Meta: U2FsdGVkX1+eIOTWXKADAjXWWOcoYfYM3njnhOsbJZUsJ3xR/8aWoUxt7uEND4yfBzmDOVtqm0imddAE8bvm1jgaFyZwm51rXSFRmihr5EIxRcJqXfG0hmqd3pvMGDiFwnFD/bQ8si/lyMxS3Nce94NVPicv13EqG92HuV6xtaFXGykjfNgOua0jppwycSPp+rUDg1Dm8KKooLacNJD3TaZIjgP8cOa1qV4dzrhW56Uk21KVygVGmuf3LS1yULruMAXtYJGLh6yt6YNh6fzcjGb0uSRpvpnDYEAoMPIzn9zCmL1no0yIrkYAC27jsH3vtXa/n7qV/1LYQ1FlDqrqzaO0n6gizP/q

On Wed, 11 Nov 2026 16:41:37 +0800
Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:

> Poll and wait paths set the pending waiter flags while ring buffer
> writers test and clear them without a common lock. The irq_work callback
> also accesses the full-buffer wakeup flags concurrently. These plain
> accesses cause KCSAN reports.
> 
> Use READ_ONCE() and WRITE_ONCE() for the shared waiter and wakeup flags.
> Keep the existing barriers and irq_work wakeup protocol unchanged.
> 
> Fixes: 15693458c4bc ("tracing/ring-buffer: Move poll wake ups into ring buffer code")
> Fixes: 1e0d6714aceb ("ring-buffer: Do not wake up a splice waiter when page is not full")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Is this simply to prevent read/write tearing?

-- Steve
