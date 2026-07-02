Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836F3749F6
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973891; cv=none; b=KNyRBTH3PBT+pDwjMB+AfCeuX6lK2OOTezPfsKiPYGRWVl6XI12WRwBE2OFjXOClqSCSAzPTx+abFdUDtMGlatZPwadW3dBgx/ZMnFu2/OIebL4MfoYBRNE1bD2YkDcz73mOyR1HQV9rNH4lXvnMDF2uC2RmtkOpIwe6TqPvsgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973891; c=relaxed/simple;
	bh=ef22JhW2G2o6sHdaFSTiYhD2+Z7kj6y2VxfpX3pi80k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfMGngzxEQ2x/0xfMte9MsBNrF06VvE4pq0nDa2oh0y6+fPW8A1RgKiNAFPEwa6zC23Bm02H3N/WuZloApiXNEsB/msRj9DfWCiP7Uwk1HythtfwCGOKpucSvblRBSJXU9yWpkDgGwmbxrXMhkBD/xZUk2L8Y3MJUmk5tvOC6NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eenVnCfZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eenVnCfZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782973888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ef22JhW2G2o6sHdaFSTiYhD2+Z7kj6y2VxfpX3pi80k=;
	b=eenVnCfZdbIhoPzpMYxtODy+v5BbtMw5kFlnbgQdLyKesnWZ5TyOCKqa3eupeWvd0deHmq
	xBji9ogkx519uYdd5cEo9tBUOzw14t5rjfPnnKcFVlaO1+IxB7BBgkqDPFhkUzIcB8xihO
	LcAj1mEiyu/uaMbjaxim6WGvlE+NHMk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-GsoqpEQpOhmWtAtYfnY6yw-1; Thu, 02 Jul 2026 02:31:25 -0400
X-MC-Unique: GsoqpEQpOhmWtAtYfnY6yw-1
X-Mimecast-MFC-AGG-ID: GsoqpEQpOhmWtAtYfnY6yw_1782973884
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4729d2a64efso200626f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 23:31:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782973884; x=1783578684;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ef22JhW2G2o6sHdaFSTiYhD2+Z7kj6y2VxfpX3pi80k=;
        b=XIwAOdVsLJejJ5d/wVu+j8vijXF5n/kGvXwjbbV8F4SBMswS/tUuQnBy0j5D9HIJN1
         YeMsx2jnr1QhwWHHCpig4a96/pdslGf+m2ToZ+iz0idCj2xOj2FwQXOfKMMLMlSBGdsi
         4K5xe/ww+p2U7YczqpOUsNtcCdCHyiownj3UqoUlzzHG7PuDNzVwzY4EEeOKnv3S1Nn2
         Y3pBO0d+0RqVoOOJDEQxGiQAunRx86r/zbvGSLVpb+NdkGEUYCRbYKR+Tu91rkgWJ6DP
         BsbFW88mHMsjGn5zfOY0+d3Fv/rRZIg+91NUsNbi46sTLFVcZ7g6nooiue7uyvAlOmWX
         gFQw==
X-Forwarded-Encrypted: i=1; AHgh+RrI35ErpHxQ83KoOgNHxh35vZSnScXX35mTWlwx3q3+xKyLz4uCzvCOFU4mUO/6et4BMzuSusQGq9SfTUKm2HdFbHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMCkfpnJwW1UyzNkwTJuHyTcCYR6y7r89Bjd6o+gpdFs4BaO8s
	Ffkfj4vcb6YNtdyWvObwIL68d2uNVBawuCTRhwhNSutgnYV8zSFW0RSgZt+AXb/ybZw78xyxF3i
	lXhM7MW85I7kynhK9t5Oi8poUzqR9WieKfQeY9oJBvgw1a++ZHKTF7UTbNrPdWAqd3GqCzhil87
	C76z7CVH5I
X-Gm-Gg: AfdE7clDXExgdD+fb01J6up9PLsw0woSUpmTTGarcDb4YPm62bGZOmttkTDHVbPLsB+
	wlDrNvDuTdfhwl+kYjH+XXv1i85W3zvJX6wp/FO/hZqjN5MKinaUa97LJNu2umvgeZzHxtUTvZx
	4AZG2eqOCmbcAwWFNyjwVsWwBiVPJMuF1b24X+ZiIGzWpfpzKXjjlE3VutcWHCKKfxWtKs/v8Vg
	JjI+JsaHpBsvC2XTkie8VCH9Mn2xqQik6FlyCyxnyeQDfgIImhKR5F107IraaEcrH4wrRse/mOQ
	i/fiUVMU0nuNOwsdDdLcimkQDTqPLS8Lka+6mxTtoGWXqrsM0Jtq/WREgDo7o/G5R6kgwI/+RoT
	7wr6Fvu1nIaasp7TS/FHUZsWIOBKHXZLRxYlL+Tn3j8DlLZvYvDCgPyNHdgNVVSEVWkiNT2MIT+
	hCye0d
X-Received: by 2002:a05:6000:230f:b0:475:f0c2:75b0 with SMTP id ffacd0b85a97d-4774662f667mr6845138f8f.27.1782973883837;
        Wed, 01 Jul 2026 23:31:23 -0700 (PDT)
X-Received: by 2002:a05:6000:230f:b0:475:f0c2:75b0 with SMTP id ffacd0b85a97d-4774662f667mr6845112f8f.27.1782973883483;
        Wed, 01 Jul 2026 23:31:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dd0b1sm5843067f8f.35.2026.07.01.23.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:31:22 -0700 (PDT)
Message-ID: <9b349d2c33e356e735050ddbb6fd005b8870a7d7.camel@redhat.com>
Subject: Re: [PATCH v4 12/13] rv: Fix read_lock scope in per-task DA cleanup
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Wen
 Yang	 <wen.yang@linux.dev>, Nam Cao <namcao@linutronix.de>
Date: Thu, 02 Jul 2026 08:31:21 +0200
In-Reply-To: <20260701152705.6dc9d8f2@gandalf.local.home>
References: <20260601153840.124372-1-gmonaco@redhat.com>
		<20260601153840.124372-13-gmonaco@redhat.com>
	 <20260701152705.6dc9d8f2@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YtAvNarM4RPyY5Ubjh4ZYVyrgh9yEzPjOj040xNib28_1782973884
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-07-01 at 15:27 -0400, Steven Rostedt wrote:
> On Mon,=C2=A0 1 Jun 2026 17:38:39 +0200
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>=20
> > The da_monitor_reset_all() function for per-task monitors takes
> > tasklist_lock while iterating over tasks, then keeps it also while
> > iterating over idle tasks (one per CPU). The latter is not necessary
> > since the lock needs to guard only for_each_process_thread().
> >=20
> > Use a scoped_guard for more compact syntax and adjust the scope only
> > where the lock is necessary.
> >=20
> > Reviewed-by: Wen Yang <wen.yang@linux.dev>
> > Reviewed-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> Hmm, this and patch 13 didn't get applied. Do you plan on sending them la=
ter?

Yes, I didn't add them to the pull request since they weren't quite fixes, =
then
ended up not sending a "normal" pull request for 7.2 just for these.
I'm going to put them together for the next round.

Thanks,
Gabriele

