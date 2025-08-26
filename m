Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D42F0C48
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231582; cv=none; b=NMwqN83IU+yjBnpH27dM+yCR90MzT5SD3zmmTjW9c3Df3YK4+Sxa2DCt0uqaF8m29IITPZr4O+4dMU4sI49D12g2ypsKt5k4upevKgnqKtvzNLvzIlg+lxb4u8xtZC63BEdgMXTsFEpw9ULnW67uko71QQHm2rScLkbFjfjhHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231582; c=relaxed/simple;
	bh=pH8IhwCPAW2cFEl86QIBYeqE0tT288SOvA5Wpse+NAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rfu8BXjfHCkdyTyyQrIpFq3AZxw8R/EHNfiRCIkVtGgAV/o+Umu2mvKLdKVWmRKCYXK1zCD0rzjimaSNlisCq1iO4VifYVWAeEGTmZe1yDmPWpP30I8z0hlubiYPr19dtXYgwArBdbvospWtqefsN0bHeMrjfhkbuW+7Sn7q8hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cwDQJbYj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwDQJbYj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756231578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkUzF08CL30OlgFUOMagbzRY8wR7aiUuy5bP4+XNnL8=;
	b=cwDQJbYjPCaEs8Xd7CXe/Jtj+g2UJ6WyGZQ6VJ/NxL85ARoLgh+ENFf1msaJQtI3Dz3uIC
	bJhn4lPn1t+9itLmzv1B0sIwsz3MOKpzKCWkPNgJ3+ojKPvlixCPTi+1hI6m6r0XncVeT7
	bCrGY5O5nEcIrBIKj5lLiO88wF3x3Po=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-F2euBAFgO5-c3pP8RV2Daw-1; Tue, 26 Aug 2025 14:06:17 -0400
X-MC-Unique: F2euBAFgO5-c3pP8RV2Daw-1
X-Mimecast-MFC-AGG-ID: F2euBAFgO5-c3pP8RV2Daw_1756231576
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afe73808e6cso348092166b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231576; x=1756836376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkUzF08CL30OlgFUOMagbzRY8wR7aiUuy5bP4+XNnL8=;
        b=IAtRBjiBXK4s2z785dJk3aIK3u0+gdFDh1dqS7/hSV7RxP1ovfnOfY4S9z9bV3KvmQ
         iJaBdWbmSlbg/757ICerVqvaf2+En284ur9VJc6vTHwitMZl6PLlUfPqyYnEXv+0Picy
         r0hgctT/0LOgAYV7yLUkdtfP5VbQGaSmumbnElWVVtw1NmT2UTWB3KpjIm0w9SRBQWpm
         Sq1MlBYZoNyR4kpNB+z3q6WDK0wHu4B1c1x6mNlkQXrprAjSEqy4Gu6eq4PAgJ6OUIwS
         Z+v3+rTzMMZoExsIQ8OCQCIk1Ue55W+TbWkF6PePjLXb/KMZR3es6vAL7QXZEXixdJ2Y
         W0zg==
X-Forwarded-Encrypted: i=1; AJvYcCXTvcLTdtN3y6IcOZl6nGp/Uhth8GjRXqLJWko7qETAbS2amzl24ckNHnWzF/3Ok/MQspFLvcmukbaEEpew7q7BGqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMXVF5TLaYM+XtS+S1VNb4T/I4cuKT3kL3UV3t9uhDKornOvH+
	KZXWpUNmiPNloUqWgzqf27tULPBV3Vg/7/qRrOa+9fQbpcashl/xVY+mBV0A/AEGv7Pe2qYlmIu
	4U3KBWRoARugR8nImEmtssEXivuAy8wWSukDhjjhX3rB1wSVJD9W2fUEOgfPS/gWgRJ04gurl6k
	6OIyHIXnrhRT8P0QJSAVQEC3xObPeeATraMVjuxIoIEWahSMhW
X-Gm-Gg: ASbGnctBYrvCqQaE37cZpBUq5zIkL+ASKVxXm2RvPr9hcRrl2iQxTiwTLFtaSU7YWvn
	yNNbLyKej9aJAbKXK0/22S7zoWcMkqPyRmTB6X/hiKtM8ExB5zzsrCz+IwKHOhVZzeysu0wP+QJ
	p9bd0kCk/x9dHO3Cz7fRJpYlBUiVhme0PU+jcciP4kKA/RlZHEDfS97sE=
X-Received: by 2002:a17:907:720c:b0:ae0:ce59:5952 with SMTP id a640c23a62f3a-afe296afcbdmr1496452466b.60.1756231576314;
        Tue, 26 Aug 2025 11:06:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6XUvv8eW9SmjbpylKf1ZmU9wkH/I2uhXvZR69IIMCfM9px1FCfKaXZTlXGww2dH2ddK3qXxR/cl0ulHZ++UA=
X-Received: by 2002:a17:907:720c:b0:ae0:ce59:5952 with SMTP id
 a640c23a62f3a-afe296afcbdmr1496451066b.60.1756231575945; Tue, 26 Aug 2025
 11:06:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-3-crwood@redhat.com>
In-Reply-To: <20250821035719.137161-3-crwood@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Tue, 26 Aug 2025 21:05:38 +0300
X-Gm-Features: Ac12FXxnq737rU4f8-br1KsaA67p80xwyhQSxKbQJJVlA8X-tOh6ED451YMe0uw
Message-ID: <CADDUTFyDJGTKU9vq_f4AjV_YJtktW8LHRZuwgJWh5nPAnwUvBA@mail.gmail.com>
Subject: Re: [PATCH 2/7] tools/rtla: Move top/hist union members elsewhere
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j_9dFegiz3kvyijf4A8h0D6UJDlR3Xpc0LAsYkeMUss_1756231576
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 06:58, Crystal Wood <crwood@redhat.com> wrote:
> The hist members were very similar between timerlat and top, so
> just use one common hist struct.
...
> @@ -27,4 +38,10 @@ struct common_params {
...
> +       struct hist_params      hist;

Moving `hist_params` into `common_params` could lead to
the `common_params` struct becoming a "god object" antipattern.
The `common_params` struct is intended to be tool-agnostic.

I suggest we use `hist_params` within the tools themselves,
rather than in `common_params`.

Thanks,
Costa

