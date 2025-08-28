Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DBD2FF657
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368566; cv=none; b=ntjOjPEeYJ3fR3oZ7I6daieGmJyK9BeLWslcv3CddX089XZn8JXJhI1Mz7ylcn41oAQW+eNidHz+2bgkCK84r62TPQMHfZkZidLXEQ+9hl3SXmnIWH4nLHvm3XaafvbkVsCwO0R9tNNPoKYMasRm1jqOxK79GN2ClPa+g5FNVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368566; c=relaxed/simple;
	bh=KWLppW27q/4Diqwf+MBTjS6h1YzQ2wdwo54JdjAjV0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7isaIdnVxUEGV7VfVeWJJaVRgRMdMUOKZp8hHZOWYF3FcalGVFuJd7rGGxdWhhH1CPc4yAUExCc3GMbUNeorPaqgFBTqt7o2LmYWO5oJGgNphNjs93zFrD7KGWlE3385gVR35/g+jVsm52M52F1W30ifwgYWchoMXE7WYj8sOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xs6Youh+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xs6Youh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756368562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1X5xYFvxFRrDibTBm3CBqs8PX8cBvU7VPmwkuKPTwg=;
	b=Xs6Youh+V7UlcSrp8yEtbLMert6EDY6WS6G06DPEXg7W0kC4myVjyvwsU1Bu1bOXM4e8f7
	Tgv7CQv1KrK618GtVHwuNqArV0xa6qdj46Ih4DguejveMCvrulw8Za5+vTgJth5UTeOSCM
	JpwDEpzv8Pd95jYc5b+wqcXuvSttH8Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-9bZr66JLM-SGR621wWRFQQ-1; Thu, 28 Aug 2025 04:09:21 -0400
X-MC-Unique: 9bZr66JLM-SGR621wWRFQQ-1
X-Mimecast-MFC-AGG-ID: 9bZr66JLM-SGR621wWRFQQ_1756368560
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-afeeb44fe3fso25587766b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756368560; x=1756973360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1X5xYFvxFRrDibTBm3CBqs8PX8cBvU7VPmwkuKPTwg=;
        b=o0TKb4KkiWC4R7jZl7tgnlcg77MY4/A7vlFGdi27yKyAya1pzMy7Pi0wMyzTmyXC/3
         U5vqidv83U3j7d9IUKKhYFLUavaedWpOt3aaRFwY0MNiUXbIHnWHYq2NRh2IrE3RI5id
         /nZMkEPL9GR8+9xKKeTsuKDqWXqsguUEXCdDuYmvHhFlybI3OTKybePoLMCsS9UjooaQ
         Wy9y9Khe0h+Q9toiyGpjT4DborRUAvnt2doKmJYVYFbkRZkHm5YY3s6ZAb1LtT2iGEwH
         XC4LuvyxYiycN9trcnrH/5pzq5osTOWpK1Hgd0AOK8V5kSPye7g4GUM/5SEWK+Gs+r8l
         bJog==
X-Forwarded-Encrypted: i=1; AJvYcCXva/IXCOl3uAbRybrZjUpJiimi3fdSGA/xThmQgUNu+kwWQ1YVjlgi9/l/tyV99T01NJvv+lUBX/mb/z6+nJgT/bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMHdocZjC3MKZ6f2c0fAbJ+scM7r4XuNee1knYZvgS3HGZ1VaB
	T34rSXKVdV3O8uPAuJ8fS/m/Z4cVgymNrtWTUVvnBMAC7YwfdtAzVIgjdg74YFz+T+9tV3jq6CE
	F0MhEmtFyHDY13QCUOGlcAtcEXLZwUCdK95Igl3JivfjDoRuzu4RZ10RNqNqUJgrLzJ0SHq39LM
	PQKBjzqF3Que04N6/w0JroPbx0F4VP5sQcgigLKT8jc3Ov/irO
X-Gm-Gg: ASbGnctl93BjWxnLN/04DkEbhvxvumLPGolJFl2onPIShNwELl64bpg32K6KFYJv5D6
	OBLkMPGXQCj3APDEnQ0QjcwbI4lOh07YVopxmDKc14MihNwkx5Xjw/XC6o3nS2Hl/OSG/whTB5P
	EZeWPUx6s9uPzFlrADbQY=
X-Received: by 2002:a17:907:72c9:b0:ae0:cc5f:88ef with SMTP id a640c23a62f3a-afe29048ce7mr2180671066b.32.1756368559700;
        Thu, 28 Aug 2025 01:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/Pp/IS16Ptj4fYRr9tGLSsAfJHMWl+3v6JgoiyGrvraFv9v4O2zf+cCIcianCKMxQGHIgguBYwcbwQTyAaB4=
X-Received: by 2002:a17:907:72c9:b0:ae0:cc5f:88ef with SMTP id
 a640c23a62f3a-afe29048ce7mr2180668466b.32.1756368559221; Thu, 28 Aug 2025
 01:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-7-crwood@redhat.com>
In-Reply-To: <20250821035719.137161-7-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 28 Aug 2025 10:09:08 +0200
X-Gm-Features: Ac12FXxxiiozQ3xgHpFGeH1oT8GgzVSXXUHflx4r11TIim38PG_b5m52qIfSlJI
Message-ID: <CAP4=nvQthvoE9tGPqbXmk3dP_XJjmgkh_wXDd9JiVTTGvM3nKQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] tools/rtla: Add test engine support for unexpected output
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zur4do7ZOx-KRyLKVrCuk-6JwBlamayswr2Qb9mbPPg_1756368560
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
>
> Simplify the code so that we can print failures as they happen rather
> than trying to figure out what went wrong after printing "not ok".  This
> also means that "not ok" gets printed after the info rather than before,
> which seems more intuitive anyway.
>

This change is causing some formatting issues, e.g.:

tests/hwnoise.t ... 2/6 # Output match failed: "rtla hit stop tracing"
# Error iterating on events
# Oops, error disabling tracer
#
# exit code 1
tests/hwnoise.t ... 3/6 not ok 3 - set the automatic trace mode

(the comment is on the same line as the previous test)

Furthermore, it's standard to first print "not ok" and then the
comments, see the documentation to Test::More [1], so I think we
should keep that.

[1] https://metacpan.org/pod/Test::More#ok

Tomas

