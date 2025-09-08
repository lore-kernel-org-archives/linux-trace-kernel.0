Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44DD1C07C4
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342898; cv=none; b=TrMpwHnGDBUSf7JPIKsRHrBDGOIEZbehWkztZb1o7eAKGeMrRTZBrEF4zZZX/t57B6pAyNk6TWQzomFRjq8TVTjVsoNeksJEaKkrrHJyGNiXoYCUA378nx0EikNf4Ah7/J4eWjgaBYU93ppR12CYBLikScIOM/DrHlegTLiMKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342898; c=relaxed/simple;
	bh=wZNl7eycZG5NTOJezAbjhmL/CqhonOBDOVxjsfkU7Jk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXC6hyAA6EuMTVW/MRQ2Q2XGiPJK6GEbBCYvQr78tocfyHygvYNSeNnGj1KGvpqINbzeC49VGmCE+diOAYDipywWsfv2+BFMRJmDYEy9dz2qscbLK+2I3EQncRiMU35oY/q4iIpkAX7Q+0aQKMbhi69ZfoVQH8KsYm185rTXROw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A9JZ1PoE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9JZ1PoE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757342893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAha/Cuitu476bZ7HFAeir03avfwvbt+xFJIGg/4QuQ=;
	b=A9JZ1PoEn/9uzBKKm9sp1C2eP15h4opxMLI4IRbfaWEWujn4j4d6T1gq5/hBQvPP5jqp69
	7umlbU1U1cHT/8ZT1xtO/UlgJ9iYdWt16IHDP0Or3uwlrJc+GbuSSTGQ9xedXxpSS92ItG
	vDkSAvhshelYkP+HNFz9+OLzZ0Yke28=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-D11nuVF5Nj24LGj4-zESvA-1; Mon, 08 Sep 2025 10:48:12 -0400
X-MC-Unique: D11nuVF5Nj24LGj4-zESvA-1
X-Mimecast-MFC-AGG-ID: D11nuVF5Nj24LGj4-zESvA_1757342892
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5ee6cd9a3so80996661cf.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757342892; x=1757947692;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UAha/Cuitu476bZ7HFAeir03avfwvbt+xFJIGg/4QuQ=;
        b=paHIGZz6htn3GtweESIxcjvLAbFnazwkxBe60+CTBEwAZEeTElCT/hFVJsgW1WG/4p
         eMknRU2mAxr3bequPE0axrlr/a7MHjvoHpFm2ijAcRANA/AfhYQN0nEHlEk881eOZ180
         cfWiGspDe0BOo5sYkSSOYaV8/DVPSflbNkog+owYSUn3u6xg+PuwFUxdPKa/VAXZdttn
         GkR1S8WXYx/m2QhxaHOj9YvXYSKXebqLGWxxPCZBOm/vCKLd00Kyd71WGfRQeoiV0nFE
         6N2HldT80yb5gnpHh8DO485nS3OXhSQqoPoi6wQ23RvWzmzwAeh6yb5JWFuieARjO9vM
         2ydw==
X-Gm-Message-State: AOJu0Yyg+aLRmKIPjnA2mUERDLiB88wIlXJYiAnU0uKLttwJ497S98Zc
	wW3udjZVw1lpS/wLuj9Wga5k1fWusqTzf5o1uzr76OLYXeoPSboB35ciblVwQwlAspd2aj2EZVP
	xzIe2/QDpZ5IMzWpnjr4kwTcX5CzjV/XtRDKWxbqfUP8WZUPMXHaBKIZrAfWBxiIfH3doVTIg4w
	==
X-Gm-Gg: ASbGncsmVOaHIDTUzYzYXWYcDgwUoTmnpipfSNFvROc0cmu4GEmLykwCdRbUh7TkG18
	ZfXd9M4vvUk0VZAYyFAzdY1LgtYQJjMrVsdQu7t9Zk1IpxTiyHj5y2lY09qQvcqqf60g+wP5ku4
	NUnmw+a1EclV3iT90hrCoaWO5uLfpmQN6uKqWkHmhzOkBU/F2gjNxzi3WcU88xExXpdTPoHYIqY
	Ywq8QAp0OPdpu/NDRhCytj9T4ue9mOJhjBq2W+Y+CAS+ZUjrBs0rHTOntCovWWTroD7dJhGqSJ2
	vTwjzmdmsuzRsZNyxFciH0lG9JM0s1eH/0scQ/MGvDv/OU7o3aOpGB2dYCEx9bJUpEgiSNE=
X-Received: by 2002:a05:622a:4185:b0:4b5:d586:d74a with SMTP id d75a77b69052e-4b5f83e0756mr98949671cf.37.1757342892007;
        Mon, 08 Sep 2025 07:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLdgieL/B5l82jYTiqprFvmLxBMu13PlQAa54oARLKnpJ/jX1nmih2wG3W1UXMVzEnrEzSyQ==
X-Received: by 2002:a05:622a:4185:b0:4b5:d586:d74a with SMTP id d75a77b69052e-4b5f83e0756mr98949241cf.37.1757342891475;
        Mon, 08 Sep 2025 07:48:11 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f756d16sm99850001cf.34.2025.09.08.07.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:48:11 -0700 (PDT)
Message-ID: <2beae00128b235525a068527185443211beeb041.camel@redhat.com>
Subject: Re: [PATCH v2 6/7] tools/rtla: Add test engine support for
 unexpected output
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
 Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 08 Sep 2025 09:48:10 -0500
In-Reply-To: <20250907022325.243930-7-crwood@redhat.com>
References: <20250907022325.243930-1-crwood@redhat.com>
	 <20250907022325.243930-7-crwood@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jV6KEtVkHju3C_iti09MFnNuJ3MIxsnd0In7lVdCjTM_1757342892
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2025-09-06 at 21:23 -0500, Crystal Wood wrote:
> Add a check() parameter to indicate which text must not appear in the
> output.
>=20
> Simplify the code so that we can print failures as they happen rather
> than trying to figure out what went wrong after printing "not ok".  This
> also means that "not ok" gets printed after the info rather than before,
> which seems more intuitive anyway.
>=20
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> ---
> v2: Preserved the original ordering of "not ok" versus diagnostics as per
> convention

Oops, forgot to edit the actual commit message to reflect the v2 update.
If there's no other need for a respin, please just remove the second
paragraph when committing.

Thanks,
Crystal

