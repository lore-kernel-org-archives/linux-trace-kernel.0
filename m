Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C052F8B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 12:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773317871; cv=none; b=cb/Zy1iqbqHfDoHQOHHyEqjGRFrfPPIhSYvLYrHQ3KS+dB974FbNIR22s5GWpyTLoowxMboXeEN3y7Qdvv0BO7bMWe4cvA1Tvb2Mx92AXWoAXHL8kKni0IgEiO7GsAwegsp7Xut/8udOYSfgP70x9Db1CbAaCTH+1krgIn8e5J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773317871; c=relaxed/simple;
	bh=Y8GxjVRD8Apu88bVk/HKLVl5r2+YOiziAVk1c0j/lTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8KVnJ/d0IQZ0PNAaHmhIW4MaWtoapoNwICE4+e5y+8iwN2Vx69pc4Y0yvH+IfgsPIyge9I1TVA+2YZms14MPy+k0CJqQybfJVgxhegE659VSiXf0a6zMmuTywD3euB2H0PMsk0gtWRpZuguJXDDh1562DzVN/XXI+fUBrcDGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoBtzep9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoBtzep9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773317869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fv/IdyPPMjitQJ9Y48M00/0r4huM0cWU48LQ2/sF1BQ=;
	b=eoBtzep9ZafzMpk9Kb4Lw2zSntjWlUg6l+d2j4D2QDTubXbcM+mg36mwC31nZRO1V7t6Ae
	reDDbfVnSWu6al2dyuJWulGo5U+053MS6V3yphiXiPIHG2UcA/sKJg9/kqixgF2tPXtk+G
	Bx3NjQ9If3SJjKyllaqxjGT+WvEObaQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-NcHct50QOd-_iyzcQYNZsg-1; Thu, 12 Mar 2026 08:17:47 -0400
X-MC-Unique: NcHct50QOd-_iyzcQYNZsg-1
X-Mimecast-MFC-AGG-ID: NcHct50QOd-_iyzcQYNZsg_1773317867
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b942c260b5fso108447566b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 05:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773317866; x=1773922666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fv/IdyPPMjitQJ9Y48M00/0r4huM0cWU48LQ2/sF1BQ=;
        b=ESY2VXo4xCeSdwE1WyGBIsMbqACIog2fkoOrzIJvBjL5GDNbSZKxlDaHrTK8P4edQW
         wGzKkkOYU2bTUshCUT+VQzbcP8B1yGWIcBpIKp08xphdpv7yS4kur0sNPSRgwF90mnst
         7cewhFuonXz12UgAbK6qRdcJX7HIlYr54scpFhCrFUBZscb0fcBAremtuhvdJDNNohIg
         fQ0IFXPyeTQakvTMo0q6T4Ay3fAsIIUQ0F71Merxnzh2kTBaHhI2oN6HjSntgnVplT9Q
         H4tJ4wBOmK98IQevxgnIrUDBC+iYcRuMHkM38JteQkppRP6pOlv7OdFyGoGdqa6TFh9i
         ds1g==
X-Forwarded-Encrypted: i=1; AJvYcCXxLjOlatESCl5cdagRcDi6ddts6fFNmFC44iHiQ9S4Micac72+HkulvW89scaCxGOhEhFbQq3IVY1U1UCUOlhaj0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrxKFeCAnzj+5y4bdEFQGB/POKZDFfsNwv2erZ2e+b+ONBx6y6
	vIUoVG1pBkHDPm0Rb8van/KHjKWkPWoWguY6u3AraRCTUYyTNOsp4MWCoV+1x5MqAXufhspz5It
	t825oUvrm577ZxYgrFrQepA7CbAFmNYCEjhzS4SB6tBSbNaE8F2figZaDAWi05Yv9yaulXFFNEQ
	+sWgh7bEpl8iASNb+gWtt4CxZOHYo/tTlxx3hGq9ve0oAP3o9M
X-Gm-Gg: ATEYQzyOBjOeCG8PfNKC7cbAICkQvRd8RBbvRoqk3GLDV9sbfHjZKVxtwKX3hMfjFGh
	S8d38XT2ZodiJcoNJIEBi5GgVbug9fOCxcy4nSc83P/DA1v4qSdz7AMsDHgLQ8BXHR1aH+Ax1U5
	Fkgze36/muOD6VSbc76Jol1znGgSB3q/ozGVCaTIJLNRlOEwa1OqV/rP79Y6PlyMgsXt0AIZcy8
	b+kOA==
X-Received: by 2002:a17:907:d0e:b0:b96:fbeb:f791 with SMTP id a640c23a62f3a-b972e52dbf3mr344027266b.47.1773317866498;
        Thu, 12 Mar 2026 05:17:46 -0700 (PDT)
X-Received: by 2002:a17:907:d0e:b0:b96:fbeb:f791 with SMTP id
 a640c23a62f3a-b972e52dbf3mr344024766b.47.1773317865935; Thu, 12 Mar 2026
 05:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309195040.1019085-1-wander@redhat.com> <20260309195040.1019085-13-wander@redhat.com>
In-Reply-To: <20260309195040.1019085-13-wander@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 12 Mar 2026 13:17:33 +0100
X-Gm-Features: AaiRm506rAH-yhuxCZ_tSpZIAy51Q5ko5bRzudg2PNgMFtqu0BW3sF-mgEVupVk
Message-ID: <CAP4=nvRJXseK41UKN_=r-1LtSF_pMJbPTQ0xuznp9MSMcxx37A@mail.gmail.com>
Subject: Re: [PATCH v4 12/18] rtla: Enforce exact match for time unit suffixes
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jjGEv6mjzZimSch88ELGQ6c3liYdhP1cmdqlVASApzE_1773317867
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 9. 3. 2026 v 20:58 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> The parse_ns_duration() function currently uses prefix matching for
> detecting time units. This approach is problematic as it silently
> accepts malformed strings such as "100nsx" or "100us_invalid" by
> ignoring the trailing characters, leading to potential configuration
> errors.
>
> Introduce a match_time_unit() helper that checks the suffix matches
> exactly and is followed by either end-of-string or a ':' delimiter.
> The ':' is needed because parse_ns_duration() is also called from
> get_long_ns_after_colon() when parsing SCHED_DEADLINE priority
> specifications in the format "d:runtime:period" (e.g., "d:10ms:100ms").
>
> A plain strcmp() would reject valid deadline strings because the suffix
> "ms" is followed by ":100ms", not end-of-string. Similarly,
> strncmp_static() would fail because ARRAY_SIZE() includes the NUL
> terminator, making it equivalent to strcmp() for this comparison.
>

This fixes both the command and the corresponding unit test, thanks!

> The match_time_unit() helper solves both problems: it rejects malformed
> input like "100msx" while correctly handling the colon-delimited
> deadline format.
>

It now fails to reject this kind of input:

$  rtla timerlat -P d:10ms:100ms:somethingsomething
// this is also parsed as valid

But that can be fixed in a future patchset, perhaps together with also migr=
ating
parse_seconds_duration() from prefix matching to match_time_unit() as well.

That would prevent the same imprecise parsing issue for -d:

$ rtla timerlat -d 1somethingsomething
// this is also parsed as valid

Tomas

