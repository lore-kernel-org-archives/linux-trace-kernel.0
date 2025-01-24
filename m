Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA77218EA0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jan 2025 09:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737710679; cv=none; b=aLTXMIhjqPQAgFhmaIOK/eJ2aKE/5xKojx8dwDpY1C1DBAhCgkr0W5NOJcBuTIiUjy8fcaFEkaeH+USo0zaOlQvIwIWv7iRHdSHHmtJocz2FARZvoeHZhgcH2ezMFJeqVXVnjuu7Y3pvsruNf4v4Hi1FE+3WvEFy2FhxZIIZklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737710679; c=relaxed/simple;
	bh=zo0ZvJAOEYeVFnljSfQuWuY8Qu9Z5Oyu5vHnSE/OKzA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9geSwj5WDAV0FCbJJpniHiWx7eYN3/6Al+3oqj5y1aMCNMz4rnCvoq68S4AEdicx8F3QCb0mEPpBS19qvGayWyWEF6+CpvsCrMAvp1/YTbecOB7y/oJnMPZDDbMvy04ccDKm7l7IuaBMpSPgThi8myyvVTGTElqp+cHhqp/wR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOQKKV0o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOQKKV0o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737710676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zo0ZvJAOEYeVFnljSfQuWuY8Qu9Z5Oyu5vHnSE/OKzA=;
	b=iOQKKV0oo1G9H8y3gNWqRiO62gk+KxF8sh0l2DI60onj9FyfCXZjHKAEAg6G8tlDkihKiU
	1jANEn9RTXXiNedxVYFp04cfxdahd+8eJ4BFTAwGXaJ0eXXJLZDlviuhGUBCYi38HagByx
	S/oPmPNbsJcfXCxVV7pA6SGbbzdVAb8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-YtHC9bZHNJOjn2ikOFC50g-1; Fri, 24 Jan 2025 04:24:34 -0500
X-MC-Unique: YtHC9bZHNJOjn2ikOFC50g-1
X-Mimecast-MFC-AGG-ID: YtHC9bZHNJOjn2ikOFC50g
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436723db6c4so12815495e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jan 2025 01:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737710673; x=1738315473;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zo0ZvJAOEYeVFnljSfQuWuY8Qu9Z5Oyu5vHnSE/OKzA=;
        b=KQU0YGln9y6QmePaXsVJtP5d1FVWry3OoRv5O9CpJ0aa9iuobGtX1QGaOL8OdDiqC6
         e8Qt6J6YYJJSgQlu387DqPEEEkEPRo/1daHIsPA3J1WdnyLz09+ylpOgLIY5i0gwfyR1
         EBE2M0TTJw/dAXvLxa7EXchTcP9SWn8oeQkw84UrgHefBzUXMHd4LD4zTBrcpde3CHhC
         +b+iDnMmswTAl0zAGWpTJFt+pFuNNEddDBSHZpEthsPjDLtMWpL0Mxp5N9SHbPS0KY43
         L6Lpt7eWd+UTCoE1Y/Tk2d/uAVPgXSPRgzAFiWiGHs4IEfPC9OBpbacdd6HSuooUuMvW
         p/Kw==
X-Gm-Message-State: AOJu0Yxf99RCTP3cShDOf45ZySsff2nBWo1tWN6ujBlvFSvrdxJ2V88Q
	ZR9MlSosroAuqsJUQTDGE6ic1AL97TjE67rCAtXtiYorkc/Uf80+ja3PcByWTOKfDyfIO4PpfYx
	eb6qKKclRzCXdV/FN67Utcuh4vfVAIM4hOmkGK2La8N0Es7mEyWrsCrvFGqruTECwqsDuCg==
X-Gm-Gg: ASbGncvUXm7RWa02yzbNo5U12lf6/7KqOCEPnL9Xs82au+fLkjjpfo64dxykfNQVJlc
	2dbO/9O1Gqs8D1LSWqal87tuHHG7CJYFmrGECjG6eix2oZ93vg+P/83oCEuzh/F0wnlzMUe/Nwj
	bw7h4y1+yLQNnA8ZsA/pEaueoPt2ehpsF6pdcUnn2u1UPAqaOFVr4S/RV0sRz09oySNF4CjGRyt
	5IXoKl3UHb5LTyuLaN1iwTmLeIUMRqBCQQAPgxPvsS8KEgGSCRBINszBdjSF7hdkbke1uOjNv4x
	0R0UOUSHFJOEaQ7YMgB+
X-Received: by 2002:a05:600c:5486:b0:434:f586:753c with SMTP id 5b1f17b1804b1-438913ca694mr271984955e9.7.1737710673102;
        Fri, 24 Jan 2025 01:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6GuHaBDFQBkrxC7V9FqZvJrg5nmwyDueR/wvWOI/O0L3QgB5S4ky2Yf9wU46zstzCgz3eiw==
X-Received: by 2002:a05:600c:5486:b0:434:f586:753c with SMTP id 5b1f17b1804b1-438913ca694mr271984695e9.7.1737710672734;
        Fri, 24 Jan 2025 01:24:32 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd507c59sm19533345e9.17.2025.01.24.01.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:24:32 -0800 (PST)
Message-ID: <3568976320e31a90e36f7d2a17ec7d42e1f2f34a.camel@redhat.com>
Subject: Re: [PATCH 4/4] rtla: Report missed event count
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>
Date: Fri, 24 Jan 2025 10:24:29 +0100
In-Reply-To: <20250123142339.990300-5-tglozar@redhat.com>
References: <20250123142339.990300-1-tglozar@redhat.com>
	 <20250123142339.990300-5-tglozar@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7OXrO2JZZ4vh99LFwf-tm7lnGllrKvCGuOARUqOXicM_1737710673
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-01-23 at 15:23 +0100, Tomas Glozar wrote:
> Print how many events were missed by trace buffer overflow in the
> main
> instance at the end of the run (for hist) or during the run (for
> top).
>=20
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---

The patchset seems to work as expected, I get the number of dropped
events and the percentage, of course if I let it run too long, I get
unknown number.
Tested on a 128 cores arm64 box with -p100, known to miss events:

run for 5s
4611870 (24.12%) events missed, results might not be accurate

run for 1m
104653605 (45.44%) events missed, results might not be accurate

run for 5m
539717695 (46.85%) events missed, results might not be accurate

run for 10m
1098569155 (47.68%) events missed, results might not be accurate

run for 1h
6749574550 (48.83%) events missed, results might not be accurate

Tested-by: Gabriele Monaco <gmonaco@redhat.com>

