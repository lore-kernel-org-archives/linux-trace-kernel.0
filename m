Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34723419306
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009704; cv=none; b=OP2vxVBUIycNhVLmVcH2sZ6oESl9/jD7fw4PcgOCvMCXIYYkoxRNCRouIslMF+pIIT33BRxX4ZXEsQGAk388RJGgylILfmTTf0auO7nCM5PvLAdJdtvjX9VscUH2+9N7sKvlKpzUOjHl3gKsPVsDuN4fpZd6tggcv3unQECdXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009704; c=relaxed/simple;
	bh=oGlBwU9UfSjbyqJ/iSRdVxwUExtCUbgo+rPN5uB5FG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RnQTygbbg6BOPZV3Mwc6/SO7oHmwxhlrV6iqU07NTxNUBIS0jNYVFLwuO9gbHi6hAGF1QnE1nThOJyqq1zaJWb5VBibQCctWs+4hVGHV6Sbz5GbjT3yyZZgvPG9UPoYY/OTGnUM7h7+DaPEDq+YSjuDLIGrHbkH1R7mx9aSYuy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QmllwCPi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmllwCPi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781009700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGlBwU9UfSjbyqJ/iSRdVxwUExtCUbgo+rPN5uB5FG0=;
	b=QmllwCPiutBzjrQCz6hzAXPSuUdII1I0D2z/AiYeCFpfP6vDCa7fw4p6VoYQ1n1LElNOQD
	i6z2jxcnZCyJPgpnyXbYN6ZOGOWsQ+oruRXuF8+9iZCyYsUNRsi6DtUmdmXxEdnnwdabOO
	fl8XohuYZ1Xngt3bxn4YBaOYlQ6WJrY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-0dVmo7SvMjOEYcrwGJtpIQ-1; Tue, 09 Jun 2026 08:54:58 -0400
X-MC-Unique: 0dVmo7SvMjOEYcrwGJtpIQ-1
X-Mimecast-MFC-AGG-ID: 0dVmo7SvMjOEYcrwGJtpIQ_1781009698
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b37e1f47so48712505e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 05:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781009697; x=1781614497;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGlBwU9UfSjbyqJ/iSRdVxwUExtCUbgo+rPN5uB5FG0=;
        b=Gav3lhW1AeuAF2+wzMAg30CyIZkHWdQgf1IHNh7mcHktvYJYh8FsJ9C91NibXv+C8D
         oylTWK6vj654DuPeaEo2bDiIgtXRMxkIc5O2PKLn+L6P9x80NRl6Y4BlT1IizQh/pYlh
         c373Mv08OJ1zvZTw5Zkzv2qv88/6UzsmkFymCGHF1l1JzoFo9xV0Jo407201qM8eiik8
         nyKKK0RWQJ3GLwpvLPb6Wqwz1x5Qq+LdKjmQKlceLR0+j2cTEAry34EFQ8FO9zcmKzPa
         IG+y6bFciyYgU3Q/lvHTpfB61klZSzu4bU9y1c0fZOVG0plmA8bjWQHAxPxW4Sfoj8xX
         f3hQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bUnuT2Omk4PDMsjttm8Y39h4+H1583Icw9EZsg2MJNrPrSz13fCUmDA2wgNQ8F0AKLmijRVaZV8tVCdudmHTXWBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqNSurwo6k0Yq/iE2RtLv1SUCG0ULseO/bylOUZpMjBgA1uiCF
	BIHTOoTRK6v5d8prn33v3R5md538+1vfDiN6yrfWyoVrmkRCaxmji0EG4z43MwNXfnjBpIHycP1
	EWkHyK9RYn8D8x2kQjKoqkAezCWNEYc2AWpFkw2+IgtYo1rmzlAaMNDy8dejBkCw8bUBCY5pAIg
	==
X-Gm-Gg: Acq92OH44cLoMe59UWfoKqDjCLHC+m9TCskQPdTgwhjjiNmKHRH5l9WTRl2CX7oqrEO
	+NP46px+lsSYwB0xz859UEkexzs4pgGDFEjYaSsfcahjPQFVzDfvwJQRLoUXU/1Ajy9zcug/e4W
	9X8mm+Z0vefDX5uq8pjyDS2RdgYGHPZL82kqcKw902VLV/FwNgKUWmVRbM4Zf+abqv4cDKbAiXf
	v4RA6/LRhrqc/LdwO5eKvVEzDaFD5eNmMup2s5TNk5xIw+fhXbzFMd8cFy3LXax2OAGIZrdHqnM
	+7Y57qTQeIqJ6sB2Bq7wYzjY2ti3QGzY+JOEwqKxjdrBsYDDcutKHvubTcyO+omBfX7wbdm2A3I
	htM4jeQHshQGzLVRTTlCXjXT0VPTGLFz8lxd7
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-490c260f3cdmr321699695e9.27.1781009697698;
        Tue, 09 Jun 2026 05:54:57 -0700 (PDT)
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-490c260f3cdmr321699305e9.27.1781009697270;
        Tue, 09 Jun 2026 05:54:57 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e4b5asm478365195e9.13.2026.06.09.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:54:56 -0700 (PDT)
Message-ID: <1c606fadf71a9f958fb10f1d643f6c57bf572a91.camel@redhat.com>
Subject: Re: [PATCH v3 03/13] verification/rvgen: Implement state and
 transition parser based on Lark
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 14:54:55 +0200
In-Reply-To: <8964bf8b7c20fa1a5b8ef2a7081cf8ba11d70526.1780908661.git.namcao@linutronix.de>
References: <cover.1780908661.git.namcao@linutronix.de>
	 <8964bf8b7c20fa1a5b8ef2a7081cf8ba11d70526.1780908661.git.namcao@linutronix.de>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ybMBQeLdNYvhM8_FvCx4AjJOVO_gDujxmsyma2_dVsI_1781009698
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 10:56 +0200, Nam Cao wrote:
> +class ConstraintRule:
> +=C2=A0=C2=A0=C2=A0 grammar =3D r'''
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CMP_OP: "=3D=3D" | "<=3D" | "=
<" | ">=3D" | ">"

Just realised (well, a local version of sashiko did) that we're missing !=
=3D

That's technically supported and present in the docs.

Thanks,
Gabriele

