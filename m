Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439344;
	b=nGVZHQEWi1Xl3t8t9wFTbCnsW7kPlJ+UpxN+yeKBV13cNej8b6nHLNc2BPzvw8L/0lPf
	 npW6zVaT5P+w2dRAf9Hk/IFLDIt9NMXQFBQ2iV98NqZaYv16Mwr0aVF2nuYT5CjHFVxfd
	 LBw/kn4EwaKJmY92JHYrsm7i+ftsgihClR66SUNo88I3oKyg1bVu8Op3C1ULShGaPnIyK
	 wJWTgeqKCRTt+IA9gfI/Lp8f5yqov4eytw5noCPoOM/vo5AnjNOxzUgVsG55g2h5/zyvO
	 bqvn9kS2lEKJdaaklmrkqxY/obwmI6iHqU9k7ONw70njLCSRZX1t+erzc6Z05TMIuhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439344;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=5kCt1SznHBI/DM8lc0ufVcBLb9PeUmNHDi9dt6lz6Ks=;
	b=0STENn1qHcjJ1wXYiIDU/AL3+A3/2UTF1MATCZO0G8/VMsCxEi2tkH7DUUGEBBKY2bpM
	 G/bLWKou40YSLdcKZXwLVN2srlC6bfakyUyga6QI166CEmzlX/BIYqPuyGl9sq6dOnqMl
	 8BnkcFrDxItLj8LAKJZG02kEqBqCk1CQjyM1ABn80t4dfWhe4mnb/Hmpd9u/tkKryd4va
	 a2b9R3+EvXPexfrqJG4uWQnhzIdR/M08yUWKPokFNxSL3Frin/aFyawOsIuOxwtnMlaBD
	 oPyVn5M8s5f6LxS1Q2Jiz8XE2IQl+jnfilCcUjDWBe2BJ3xJkBJvBIGoT92OBf6clQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=anM1TIrq;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B54606A319;
	Mon, 19 Oct 2026 19:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B54606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=anM1TIrq
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 6F25F80684;
	Mon, 19 Oct 2026 19:48:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id A668820026;
	Mon, 19 Oct 2026 19:48:54 +0000 (UTC)
Date: Mon, 19 Oct 2026 15:48:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/14] rv: Add task latency over budget RV monitor
Message-ID: <20261019154853.2fe2a47c@gandalf.local.home>
In-Reply-To: <6a8b5d26-37cc-4a8f-ab1d-0df2c2e6c2d3@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
	<3eb0948c9ca67f64b3b311f823cd0f7628033c68.camel@redhat.com>
	<6a8b5d26-37cc-4a8f-ab1d-0df2c2e6c2d3@linux.dev>
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
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A668820026
X-Stat-Signature: hn4jwqo3yjemjq6ea6c6k8o6fdygemkw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19S+tmX0Ey4Gf46j8Zk3mQ3sX9JRfLmCh4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=5kCt1SznHBI/DM8lc0ufVcBLb9PeUmNHDi9dt6lz6Ks=; b=anM1TIrq35IN3MkBkbnT5edAv1sWJwuRW+3UsErqNpx1KRSAUQmNDEd5eUbdwcFdRflRz8dL6B1OMjg0Bzwp5gk8VdKE+iKZGXDo3ZLBPmk45cMC6ZyYrhxXsPq+J7kaHQGiHnnc/hRgrRaXaAB/CvwDbwMskVBPk61DaxilfAg=
X-HE-Tag: 1792439334-68218
X-HE-Meta: U2FsdGVkX19eGjmZEkdLAc5+2n1IpFvOHC/vWSJ0jqE1odX5OhXppndGtcEUevGsvca3j27FcftI5x31YRoC3sid3NG4kPOSFpk2oORoYoiHvKO0urX7Wc6KvwBcezbmqtNR7wG1bRhRq5SN6isohB8uW5mYMTT5AsmkW7LObICICpJ22RBVsM0EgjuU7MEO5HlKCWxRoJHGhnW1GfcUxpgMGjEx9+F7NsGjU94MPKeavfOKJG6YvPB3/xh6A6Cgm2IxY6yN/5AkXhLmYDN5oR9G5ClQaQxARshiWuKWoEbCrwSElho86ztL5DvVl738

On Tue, 20 Oct 2026 03:18:48 +0800
Wen Yang <wen.yang@linux.dev> wrote:

> If you're OK with it, I'd suggest merging the series in-kernel now, with 
> 1-8 and 14 kept as the shared infrastructure and 9-13 acting as the 
> reference implementation the BPF backend is measured against. I'd be 
> glad to help with the uprobe and timed-HA pieces on the BPF side once 
> they're on the table.

Well not "now" as the merge window has already opened, but perhaps for the
next window.

-- Steve
