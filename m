Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7C930CD81
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240892; cv=none; b=dbCAD6EptDgDB0Fd10QnIq0uduLNcu7BhJcWTw+ooqa8TmbvybTMgN4s4IkxLnZjaeWHkqYv/PPCnxsSAyKrWw3gNMFUEmtK6i6vqyHaJtIi2N6cfLnEJtdgyCMR1eeHN2Xp1WUbT3nTkdyiKlPzDLgKiNll2gxENvZCTYQ/w/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240892; c=relaxed/simple;
	bh=ok0L8eUQQV1M3AeBVtkhB//+QHRKGoZjq6qzVkjAzlo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfQJBPiK3lKS+YoJxdaWuE85qoe7c7LJQiJifgrpEHded0O8gDXU8uZiH5q/rDuq35LClrK7H1CO2ImFxHxipMTiMnZHdN5VVFvZYD32R5KXDeQbxrmW4xsTr3K+jTcIZ8+dInb6H3cxRahv/JGppaB7cOymeJJpaMIGhs7l4BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c6toqrVb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c6toqrVb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756240889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdhgPb8V5IAgataUD2Ct9x+ze8helr1UTIrIdoEfzpo=;
	b=c6toqrVbq3ZSzXCj1ZX1iGxbWqCoko691moPCzUhR1rf4ai+AfzqxHExQFg5At4MXxeVrp
	e0oRvCxuwBVoRKKB8So9LyG9DqbK/ftrqbROm3C1tT+JzfUulUuT1QBKMP+0Oz7Z3yByRY
	kONXm0XkjkucMN+QJXk1cLa4AwypcN4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-PRWyDq8PM9aLLHuEi463Nw-1; Tue, 26 Aug 2025 16:39:56 -0400
X-MC-Unique: PRWyDq8PM9aLLHuEi463Nw-1
X-Mimecast-MFC-AGG-ID: PRWyDq8PM9aLLHuEi463Nw_1756240796
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7f6a341c9b8so119911485a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240796; x=1756845596;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QdhgPb8V5IAgataUD2Ct9x+ze8helr1UTIrIdoEfzpo=;
        b=njFS78pqFbsxfW6PeqjArRou8n40ui81chsdYUYH/ZKVC/3wm9qjtKahveDNlmx0gh
         DCU8TrFmSxYpY07SFYM4rqG8prljTMy3yKfMuFCz3CluYtJV8braQlPtNKYiU/yy+oCr
         d8KGWek70Eikq9hSg2EaJ4x1aQUjJ+JTh9+3a6Nc6czzykxXTzLx/owY39ZMbC6ZKL7p
         XaTGCxfhVQB+FLQNwNIfe76bMv5v0O0d9wL0LGqiK+8+YkAGedg8BinUwRrRMPFfF8lv
         +DIZQRAWcNjenVkeBvHvj0UGiiwzSBKXMtoDntm+ImAkemyj6OR9qSnMZgqXAu93T7Tq
         VemQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP+Brr45GEZJAHTXtGrNIVhQ0L6dykiaiANenqDNBmfaHbvwICdE0sXQu9KQtbSnVUTcJRJYWGG69rSKEp442PIrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSLkrm5w8hN4a4c/SNMJ3sTH7AvWOLogOPbac8i/BYkLvL6l6o
	4KG8Zm9ZFHzuuV6BbWicWocd0UJ4lAcRX4AhWBtKDHQ93OUtYuO6f8pIaogmHG2VyW6AoantOLi
	WZlqc0BBeCBtKCFn68AwlstQwR7EVPjHatlz5FQfTNCMEucEph8kxu/cEVyd0VLJhdxkxnDiFiZ
	vtVHl7YQ==
X-Gm-Gg: ASbGnct33OtQK5GaCUDZdaLYgIq9VZ/+9IZMbTjaVKQnmmgq0QcbM+NtfK1K1IVGCT2
	6FXzukyJrb1040SNnKpu00o0kmxdwrx6x99HN+O1KmcPSz/O6f/xoCBtqWHdSat29OK7JZXYMOJ
	r/wG7ANottoGOCHcFgyzeixZiLwEOQMjJjabB6X+JJEGLmb2OaFJI9wWOUXEUzxNs/hUYxLtKSi
	uz5IRH282+zMlboGhHivMSVCDShBghx7YKZrCOTgtO5xFpGX7HRtgPo479bl5HUFlaXO/h0KFWL
	qBM+6fJrgFVx49VSu0UrwOYz4fJGR11Km3+QCqGsOdgXHjZN0McFhppIGq0Au7R5pqSF
X-Received: by 2002:a05:620a:a201:b0:7e9:fb98:f27e with SMTP id af79cd13be357-7ea1107f044mr2007604285a.58.1756240795951;
        Tue, 26 Aug 2025 13:39:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/OXVsr1x7pRHznAz5/CleJytRyzKs33iul95v1tc2dJDmHJQyeUUoR7ZTRiDMrHzh6AT0Tw==
X-Received: by 2002:a05:620a:a201:b0:7e9:fb98:f27e with SMTP id af79cd13be357-7ea1107f044mr2007601485a.58.1756240795531;
        Tue, 26 Aug 2025 13:39:55 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8c9660csm75459531cf.16.2025.08.26.13.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:39:55 -0700 (PDT)
Message-ID: <727227ae6824323417fb00e35162a0206d2f030f.camel@redhat.com>
Subject: Re: [PATCH 2/7] tools/rtla: Move top/hist union members elsewhere
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,  John Kacur <jkacur@redhat.com>, Tomas
 Glozar <tglozar@redhat.com>
Date: Tue, 26 Aug 2025 15:39:49 -0500
In-Reply-To: <CADDUTFyDJGTKU9vq_f4AjV_YJtktW8LHRZuwgJWh5nPAnwUvBA@mail.gmail.com>
References: <20250821035719.137161-1-crwood@redhat.com>
	 <20250821035719.137161-3-crwood@redhat.com>
	 <CADDUTFyDJGTKU9vq_f4AjV_YJtktW8LHRZuwgJWh5nPAnwUvBA@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: neaVo6mJGVWeDIQYBLn3ImLT2X_bsV9HqQglk_JU1zA_1756240796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-08-26 at 21:05 +0300, Costa Shulyupin wrote:
> On Thu, 21 Aug 2025 at 06:58, Crystal Wood <crwood@redhat.com> wrote:
> > The hist members were very similar between timerlat and top, so
> > just use one common hist struct.
> ...
> > @@ -27,4 +38,10 @@ struct common_params {
> ...
> > +       struct hist_params      hist;
>=20
> Moving `hist_params` into `common_params` could lead to
> the `common_params` struct becoming a "god object" antipattern.
> The `common_params` struct is intended to be tool-agnostic.
>=20
> I suggest we use `hist_params` within the tools themselves,
> rather than in `common_params`.

Seems like that would get in the way of further consolidation of hist
code... and then you could just as well complain that the struct is
present when using one of the top tools, unless you separate *those*
out.

Just because someone someone came up with a name and called it
an "antipattern" doesn't mean there's always a benefit (relative to
cost) to breaking things up as much as you can.  It was enough of a
nuisance as is to deal with separating timerlat_params, and now we've
got "common." littered all over the place (though sometimes that
indicates a good candidate for future code consolidation).

At this point I'm almost wishing I'd just made them all global variables
:-)

Keep in mind that we're refactoring existing code that is not designed
in a particularly object-oriented manner.  This patchset certainly
doesn't reflect every cleanup that I'd like to see in this code, but I
think it's an improvement.  There's plenty of room for followup patches.

-Crystal

