Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4966A37A836
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 01:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485679; cv=pass; b=Ibhz/kFpcg6uydayoCNPdXLzf7ohwemB44rQVNH4+qnMVK6gkv7kX316mxl/BxDUv90AjO2d6tO+oo68VKkUkg/LOmZvW02D7y8pzT6XqCw9JUNNI12oOsCb0W4f+yssYz7Vm6lGNXB4b+5Fs0UO3pm2GjiqOlTlyNM/rDLe75k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485679; c=relaxed/simple;
	bh=cK0R7kBY++MQb7CTUOJ6U7itzCElNOr8R8M1UgJGgHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ieVkobvwQ5eFkgr73Wc1YicnaMhfRQKov69Gga6MHbnwbApz3N9HynGcf3HWKHziXtqRjMJkZh+4i7D+XI3t5ul4Fn5mWHJCoIhnay3Q1kzewIKUgQgfqGVMbYunxDqKw+Aga8AZSTQJSyQw5i3KIWbkUMbUGNBTvRPa1pc1iWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VE5hSOvo; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE5hSOvo"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so461588a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Sep 2026 18:34:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788485673; cv=none;
        d=google.com; s=arc-20260327;
        b=avt2Pdq9zIBNkaaSa+i1AgmqFKYWeNpjwtLLEzBKRj4AMUiYQBb3BzbY4UcyeSCseZ
         QHk4ZVrzZRR2z2iCGBJlVjX2+l/svxjkjcG2UmAKf7Lj47KWYiFrCO6GB/PYD3OwpBcu
         PvBpvxBJHKlb1K5WjptnLifdv0UvqKJ4zylZZDFpuTcNvImWTFRul0cG0oHXAFzIeplg
         gxtjoeY1sqWJ2xTY00wrjDZyTkdm5HJCNeNmLpC1TB/FVg+F6P5+R6gg3ydbY1O/pc7m
         s1j0RYKKoSwqINHUrCpkWxlw1QUrGy1QpxacmctxRorLb7NUkAH63EkOYbxkXyqXWbYe
         WruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cK0R7kBY++MQb7CTUOJ6U7itzCElNOr8R8M1UgJGgHg=;
        fh=ddGdThoiR1fryhbfYObNJrjoeejZu18GO1rXbEt35M8=;
        b=U0LmZrU5uxbei/myCoDoRCxm+5oua+i1dx6oA0CoX8ARwD7rQvaCRulvkHtRVXu+ia
         MJxSmW7kq2NVRsHq2eCR2uE7Xcyt4owvHOYOQPa/N52gf0OkiPfEHowR/vDCjBvQCT3H
         8BCXGw4ybKHCj8m6Uaznl2xrmJvgA+OnkPtv+l72d1dOFr9jqjwQK434dgDCOFPhudOV
         ninLMQdpZCwCfHSznZ5lXccQylNkdj6s3WlBwtL0mNLq716oppH7AguxW81CcLyBBENL
         pT9T5Zh+UNJZlwKZaM58znEocT3lXqEFEVRmi6ZmAvTFkrcsaZnxwSShOT2iR2YYgK7Z
         9WQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788485673; x=1789090473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cK0R7kBY++MQb7CTUOJ6U7itzCElNOr8R8M1UgJGgHg=;
        b=VE5hSOvoKIyDu+WK5S3scmCFKKSpyiUxSClcHBpKP9nUduz3LtLXCw16gOhxdJDUBH
         DwDwfmYVrAcaT5FudShhpDDBw2XV3sl6/Ne2fEOgOATBVMfF+9JB58cX4FuX1/9nKQpB
         P2oQ86sxpINC1x0XO9z6WvoKZbzJ0CjVaURl7jn2nzbRBNZvhuxp13OkNC0e6h//pdvD
         AkmGSzGPAVZ5MiQKz8tsDtor5mbmFVB71HrMqP/LrQ43+gFarsmAeBNUW9qssgsQsE/e
         pl9JI22MhAw5lJcZ5lsNFBTNQfqeLOUSyCUzcFtOgW/kPecYpuDjzWFDjLhCNG0bGdD/
         8v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788485673; x=1789090473;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cK0R7kBY++MQb7CTUOJ6U7itzCElNOr8R8M1UgJGgHg=;
        b=NxzB2SrkmHMDvAno21+ZvpQRhDcJvTmJuoyRBW7jsoXTv9+cpN1VD2AE7JscHU+S9M
         /X1p/WVSrJ97mykl3yKhRG+ympe5h/SMLH+HHBE2ibvJzBWBsF8jb2K0XVEKlKHqkCdo
         hNf2e3nhEYpCQDpf9hB63QRx8q5pjt2n8j2Soq+cMBIa8avGs7JIQAVIc7nql1jN1nAx
         AXvJL278s0txDHr/ub3qz95MER5XSUgNI4pqyp9GZ2UexLUxeGmNel9o+qdUXUNegMdm
         vNf4xuA6HM312AYhBpTcFpT8QbMFZP+GVYrCKnUDcPOMprCZpiSdj2cjHfW9JbV6qInH
         CDeQ==
X-Forwarded-Encrypted: i=1; AKwUvByXR27gARgm7LQ5wiiw3Nwbj3vL5JKw4MaVLacBrYKBQv2+lMBsSlWw/D6waXGx7meJiByIEfI4ggu5TmJIa60QyKc=@vger.kernel.org
X-Gm-Message-State: AFuF++lTywGkec7YpJB8hohohLZ+Q4G5Xx7kEaX8ivah0oyQJNyxgcCQ
	PXrJTy299EXC4w1QMMpBL5QQtVpTU+Z8mfap5T+0RL2xspDlFJ2nc9Pw3DwFT2mT7FMC9YURRsS
	23pEsjBNy6DuKA+SHuC9qgP7EjMlG4/8iU3u1xX1qmA==
X-Gm-Gg: AYBFou3OnXQC4LELdFJu3x5wYS9d+9ecMy1hkDYU4CL/rTH4twQ6b1EMBYT4JXCyEVA
	OOG8d23D7gxlc2FcBwHSATYELlgsuZ9td9BM9Nq1RVAR33B3l3csaEeJnzY/uEH7eaCym0xCBZX
	ONfHHrI2yhEUtmXfZyHBr5XQsqIWrx07Ptk+wpOtaTpTdm0cIgV8NtyZjSxGDquCaWBXcwOp7Fg
	0GDZZOJ95hBPh9VSfcna+NQKbafgXy1tRF9nerBzyK/hTYC0T6yajnLlaO0wAzJaph4RvvQusWX
	eramXn+xOeByXO3tztWLXOcK4BOlfMAGW6P1bKczgirPgw==
X-Received: by 2002:a17:90b:1c0a:b0:398:d132:ba76 with SMTP id
 98e67ed59e1d1-39b2623abfemr3571198a91.21.1788485672899; Thu, 03 Sep 2026
 18:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
 <20260901135715.4812fde9@gandalf.local.home> <f18beeb4-f3df-41eb-9990-5be295a2729b@gmail.com>
 <20260902235533.ea387f764b51b1b2a8ce8224@kernel.org> <20260903123606.6e5bc37e@gandalf.local.home>
 <20260904084808.12a9c7a1c4bb8353d753e026@kernel.org> <20260903203013.6c844daf@robin>
In-Reply-To: <20260903203013.6c844daf@robin>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 4 Sep 2026 09:34:19 +0800
X-Gm-Features: AcwNN1VvHXHQXTTD-eX-NupbI-Jls1eReHqQFNYGLhAnvQhdHuIKnq0UQhFnUVs
Message-ID: <CAErzpmsKktMM-RCH9SaF0pWirS8d3fS5Gm_ER1=HtbdrYV8+eQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Use BTF to trim return values
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, dolinux.peng@gmai.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:30=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 4 Sep 2026 08:48:08 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > > I have to ask. Why do we care? Is there a use for this information?
> >
> > If the structure itself is being returned, representing it as a scalar
> > value could lead to misunderstandings. Since we can check it is a
> > scalar or not, it should be noticed. In this meaning, I think "(trunc)"
> > is also good to me. (at least user can notice it)
>
> OK, after thinking about this more, I agree that "(trunc)" is the better =
option.

Thanks, I will keep using "(trunc)" in v6.

>
> -- Steve
