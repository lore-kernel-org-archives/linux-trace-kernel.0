Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A212820A9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768220903; cv=none; b=aBYZtVZuAJUTy5yEZlN6sejZmH2ozehubKtZx/MAfHxuPf+VosxnYdgvIrjkD6nMc0+UmSLCMUPHUNbntWL+I9Ves41gLWV6BXfuoUvmWqMmUqizpGhyQ6iU+78tieUcoRW8O47Jjy0Ta2K2NP/tiidLNhIvBEVVowai34MsJMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768220903; c=relaxed/simple;
	bh=ZjjehrJm5YvJWy0YeRhJWrcroDFcZTvx9Ps9iyiwLNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+OSxrbfbb17CFloBegcKuyQrLQSgVvzfvoBhe3KqYoxX+ES6ZNijvKxSI8P6nhOqmlJx0Eaf30K1QPQH38fGVh+tSIz5rkK3lvWC3xD3OvbOAL+d7s2nJbRC31duyuuv5SZZVvxor4CVzrlW9Yii9/gWt84lJGfEVD1vpXxw/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OitieGXo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OitieGXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768220901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjjehrJm5YvJWy0YeRhJWrcroDFcZTvx9Ps9iyiwLNg=;
	b=OitieGXoR2dyUtmIK9X9By0jF5SBjj1/HBirgT2J1iAqA+NtLhrkjjGG+kQoWdMEM4VyhN
	3ubE0d7E0sKQaVs0e4T1GmoC3X8Bkw2PXQKzg8cOzViFM44S62kFl1h1lm/MumcUgMJD76
	10+8Y3qAtiU4xi32PKiNAcazwliaHcU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-MO2ZzYYUNVuZ7TQcEvwWxw-1; Mon, 12 Jan 2026 07:28:20 -0500
X-MC-Unique: MO2ZzYYUNVuZ7TQcEvwWxw-1
X-Mimecast-MFC-AGG-ID: MO2ZzYYUNVuZ7TQcEvwWxw_1768220899
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b870f354682so130175066b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 04:28:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768220899; x=1768825699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjjehrJm5YvJWy0YeRhJWrcroDFcZTvx9Ps9iyiwLNg=;
        b=gdJHY3AysJOvoMypYqyR6fJ86MFppOKD8KgZc4o+6Va/YBtzlqXzLUTtoJ9JrWvX9R
         vAPq577hfBXvUD1PjjObWLQF5PzFCDd1vYuLTw1slP9hU7RxgNcyKpNq6qa9boz6Aq8D
         IFRlxjMArlL3XP0QbCWYw0n9c4ao0ecuo9gMo18Ao2fuxZPf0+ZP5hbA62qkh6zRPUQ+
         gzOirr05gGCW9Zqv1/OiOgoEOMsHV2tPU9jzdbzDUoJx+GQ9S65HKn/JRaatpIsystSK
         ct+/G9OQ6cvWjHNqE/3wvwHuPFsT1MoAg+HcImRs0qvipIQxIeeuka3dHLi2cAYZYyZn
         4bqg==
X-Forwarded-Encrypted: i=1; AJvYcCXI6wx60jP9Ph4rXbf/vtuUGfb+BgjuT4Z0csE1Z1Ob7n44r5VHFd45QRXLG0V2UI2xCVIBRcRRFTxoNWLZSoJBIMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ33wb89ZFWtHL0p3952XeSIzCGcJrXYY6JklowbLbFC/Y660Q
	upLOwtbVwqPnT5+ObaECE5aAx3dOttVs1P8CSzh+4QPlraGQXtwbifZlEZzCdrxVH3vIdbSRqwM
	x1bOMiDC+Tmya8YyHkW9ml8DCw+ONDzk64x28o3X//XnHwxhWmfN4JkCAQMgYvi3luvj7qE1itj
	8VCKoulcU8pIdNQ+07eyO8wiQD4M6wJW5p2NcXQFbx8UEe/CNg
X-Gm-Gg: AY/fxX7dJ/J1vBesz68enL4SM19JTeFJWibAv8P2T5fpGVM4/1pDotgh6XOGVK7rOxa
	n9EddA7MKZNi+P+pJyRg2k9ESbHZEgn8D7beaRhkgM/WqvUMxDCEaMBlNPUDiGV7HIl9DoVFzX5
	RCPkVjvgSeb8lDL9w5ngu41Fnth5exIVTjwbTFt6ZKbisKZjFLgreO2AvfmRjyuN157BPv27hYf
	zy8auhyL5wqRCUFpsB+LaLhbQ==
X-Received: by 2002:a17:907:1909:b0:b86:f0b4:4976 with SMTP id a640c23a62f3a-b86f0b44c56mr573657966b.27.1768220899045;
        Mon, 12 Jan 2026 04:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFswMhcaHCw3o3UBsbFMxIsdjmuUM7j7qYcyxN3WtQSvf2wJR5Jo/bkWE4JrCNTd2SOgC9odjfanUv+fLzqSMs=
X-Received: by 2002:a17:907:1909:b0:b86:f0b4:4976 with SMTP id
 a640c23a62f3a-b86f0b44c56mr573656666b.27.1768220898689; Mon, 12 Jan 2026
 04:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-5-wander@redhat.com>
In-Reply-To: <20260106133655.249887-5-wander@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 12 Jan 2026 14:27:42 +0200
X-Gm-Features: AZwV_QhSoEhFvhmXOHxU3fZBzDEjolu2gp5vszdmYsYri4aeAFvaXLiGhbGBWK8
Message-ID: <CADDUTFyEJxLHKHiaxya5QxW49kzWdhj=hzTygQYa9JPUOe8Zgw@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] rtla: Replace atoi() with a robust strtoi()
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1R1htj3fuLnfQbEm_9_oAU_dI3Ha0p17vTWo-3yJtTU_1768220899
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

This commit breaks parse_cpu_set

./rtla timerlat hist -D -c 1,3
Error parsing the cpu set 1,3
Invalid -c cpu list

./rtla timerlat hist -D -c 1-3
Error parsing the cpu set 1-3
Invalid -c cpu list

