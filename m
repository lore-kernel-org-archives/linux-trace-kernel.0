Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D0342CA2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062293; cv=none; b=Hik+G/R25GVWhiX6SZQPmjnVjTHOBDPiryCrc+/gUub7YLVD7BI5v+/CvxSHjltNQzKUj4K8dVGqwBTxUUWF0/lib4TyeqKLYW7s/G4JT9HWNFNn6Fg41Gobnkzmq+Upa3YCL3t31IbKQIEm89AkTjZNk7fjc2VEbEzfwq14N00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062293; c=relaxed/simple;
	bh=zd+ArKte7lBSnCcvbJeEFtoxHRPUAR2nsc5ee9j+mGU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W6XJFPp2s+7H0UG32rtjGCYUbexnK191gzdBLMMKShFJWpviuIsJQv/JUtlugfww5mw6CTIPiJCoFaxBfvY0GGChg1BtN9LjnQH5leQmqffSPaxX+V4RGwXwDGAKWJ3hfdQRHj2HnsKIhv7HoJ+TFxKjEbZY5AqQmRIpNu/iJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2CtZBHz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2CtZBHz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761062290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zd+ArKte7lBSnCcvbJeEFtoxHRPUAR2nsc5ee9j+mGU=;
	b=D2CtZBHzU65O2ya+oRymHL8Cl+OY3I9PAVk44+sdbXoMzX1X0uC9JzafUfOulhLpfOifpB
	yHGbXvxhlr+cbUQ6lse71iiUZAYTuy6wUKOC2mQVcVhv5bblp1M7go1f44zKx0uVB/iJLW
	6Me91cX4nswnpiReuyRIlZbxN9NieS0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-uH9PdHDFMZyA8AsZ-QzwCA-1; Tue, 21 Oct 2025 11:58:09 -0400
X-MC-Unique: uH9PdHDFMZyA8AsZ-QzwCA-1
X-Mimecast-MFC-AGG-ID: uH9PdHDFMZyA8AsZ-QzwCA_1761062289
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e8b33c1d8eso1111291cf.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761062289; x=1761667089;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zd+ArKte7lBSnCcvbJeEFtoxHRPUAR2nsc5ee9j+mGU=;
        b=S1aTIJa6GBAcqgaFs94MIgW1/2vSrfDJKR0fSJL5uLEafnh5XrufEtYssaARyT3xrG
         Tn0BxA7UyfNd7jNmuyEcn4+Mvuv0kY0oQngKy2WaDbMw5MLQjEivm92SEWieNpq3NNcl
         QXYPs1ru/TZhi5TW69SoZOfGDFRZIQ/G8eTBNqcJJA+qUUZDw6UaDnvXN+JfeLHfPsH0
         5IaybviCcslifFu0Vr547ruUuF1IvFHrkl5cAtvaTxxIENUC4/2l5VuOr5tCQZjoFUST
         ej6DQYFKgvoZQFeE4gEJX99x8SlonURVdE39l9gdFzWqzNWWHwHwz4g6i2TYP7FneA9K
         DPKA==
X-Forwarded-Encrypted: i=1; AJvYcCV5asHE7WOZy4aIXtbWghGLYYWOzSuW1zS+r9yv8mfiCTUsn/Gu6dLURjr3rUlW+RHQS+c39bEY+0cxHn3vGzGdOIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL/eFWU1U89FBM5HYqsrAL2QQwYq33mdzvxrVafKyzhvTwPVAL
	hFPbUEk5cQxp6HW9l9wG0f9p8r8Nfamrw/dSzy8yYKwbFsXtyTR1xyJMZ0Ea3k/sdU7FWlSfS46
	a0wnhkEtNcXlU0seBx7LWWjAd0B3iYaac1pomT0nbZ92DUOuRzQhPvlD7hKbsmS1gUoD9iHYvOA
	==
X-Gm-Gg: ASbGncsB2kHaZdVc3yjLr3+M/G4nfQa0fnLKBwrmnSmvVfJvKaFAmryaCoXqjSChVQ/
	zR0P9ar9wg+/oet9PZ+NQ9X1tdnwKfzR/KI51hLSUgHtMP+5w10PPQX7ou95Kp5hTep8KQI0Y8n
	f0rwIvhuGz02mBAirO9y9EfZHewIIEZcbQJSuQGn/mFwg2zlnqqSM1X4nTEUxDAyxhSZ0+Y8DkW
	9k6ieYsnAcBosZlIE0Q1t7LfmwbZunvK1HWXp5wy2VqhYn3WcHe/x0o7hOzpq+HJ2ruHRDstpl+
	TIKeU1eqj8woS0ZFgwzypifcrK6/MVRuVbqfsMhjkF8mtsbZ5Igk8GA5zeGDt5vbvjsNNNJtJYV
	5UD68vxOd/N0jacAnjCiwvuTD9cS2J3k=
X-Received: by 2002:ac8:5a4f:0:b0:4d4:a43d:316c with SMTP id d75a77b69052e-4e89d3de63dmr217194191cf.62.1761062288882;
        Tue, 21 Oct 2025 08:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5szTseO6I4FG2HD0vTjKdNDMZmPXaowNDyBlk3/ojACBLUbgg83sr1esbAzDc5Vj05+rEPg==
X-Received: by 2002:ac8:5a4f:0:b0:4d4:a43d:316c with SMTP id d75a77b69052e-4e89d3de63dmr217193701cf.62.1761062288301;
        Tue, 21 Oct 2025 08:58:08 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc8d5edasm794643985a.7.2025.10.21.08.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:58:07 -0700 (PDT)
Message-ID: <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves	 <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Tue, 21 Oct 2025 10:58:06 -0500
In-Reply-To: <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-4-tglozar@redhat.com>
	 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
	 <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6vfn2NtOR5zEapXDmvaH3ok_Kp7c8BmP5y_MXUUuKEg_1761062289
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-21 at 16:54 +0200, Tomas Glozar wrote:
> po 20. 10. 2025 v 19:53 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> =
napsal:
> >=20
> > We should have the makefile build this, and add a test that uses it.
> >=20
>=20
> I agree. I tried to use the example, but it would be also good to
> check if the BPF program was actually executed.
>=20
> That is hard to do reliably for the current example, as it writes into
> the global tracefs instance, which might conflict with another user of
> the same instance. I will write another BPF program that will create a
> map instead, and a script that will check the map value via
> --on-threshold in the test.

Huh, so I guess BPF is an exception to the "no generic printk to the
global trace instance except for debugging that generates a big boot
splat" rule?

Speaking of which, why doesn't trace_osnoise.c call
trace_array_init_printk() given that it uses trace_array_printk_buf()?

-Crystal

