Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1778633CEA9
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859183; cv=none; b=JRATas3pebBpfrYjC7pJI0jucjn7R1iDDqyDB1fjqnqp+VMdRSCb1xgyJ3lKaYussHjm4V2CHm3EeUH4xUtEBkkb1VRSSm8AI9PU7B+4JYSjLvAjdWPtiwSJdSMjlRmqMAjlnO6SXUo9xIPic/5qyYsr3M0zK3WlpImLY5tbDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859183; c=relaxed/simple;
	bh=nEBZdhV0tCMExfzVYExcr2Zlillv11jgE0PbIfVqKrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMlWX3U9urCg74chUzSXk7IKXIo4cxbuX0EaACKJksPkbOlIiEGOn6qtRo9G/ORGd8tiK/nvyYpHf+TZPRFaY99UldgUGlzOcFYvsbLKGeEZEKZBoT5U4Q1kAshADqphRW8QjFIxBHeuKn1vozsfhqxXtHKDbEwTQfLMOZgiV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgiKzXbK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgiKzXbK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781859180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nEBZdhV0tCMExfzVYExcr2Zlillv11jgE0PbIfVqKrk=;
	b=PgiKzXbKguUhP11l7teG1+XekRu2D911D9yeIZFUEB6gvNPkILfoBL8e0ebX96gxjOY4pR
	oCiEDNhnuo+c2LTiTyo046ucoHgs3z+OW4MD9WxI+sVUpQMUS0CDN4RjY3+yokqQMCDce7
	SFHhn/cxKj5hMauuNtmHPsvqRAyGzWE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-nOBXDPVQNnOeA3iMwvAQkw-1; Fri, 19 Jun 2026 04:52:58 -0400
X-MC-Unique: nOBXDPVQNnOeA3iMwvAQkw-1
X-Mimecast-MFC-AGG-ID: nOBXDPVQNnOeA3iMwvAQkw_1781859177
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490b7959b9fso14946675e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 01:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781859177; x=1782463977;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEBZdhV0tCMExfzVYExcr2Zlillv11jgE0PbIfVqKrk=;
        b=i030DFLHjMd8DfEmDVBABNWPaBw1FA1OIv5NbS5k5mNNvUuPRbgYOP8C4i/UCO0gDc
         qRFkfu86uL2/wb3JymcthexMOag4IFTMn1JGYibN5ZoNzknGu3X7Buzg7NaWsynwBKl/
         0yk3rIQIYRJce+0yM2xztmgHMssZEAJjLLzzVwn+RSAuxXd/8VijSd9y0h4XzhaiCocm
         5Nmw0Jh0GZWqJy90wn1RQBJ/agE5L2uPmTj+dlsAYL5m4nAZUTsN/NCel56sitLbVg2G
         dCrg2UQxNFYnm80AWK4EOd7hqkAey+cUUmH76/tDtadAvklqvnIDxuM5t/6moruAf3PL
         EsMg==
X-Gm-Message-State: AOJu0YxAc4RfPTDQBvi7fYBzEMTeaxUWXYXHZdqppaKlISledb5M5a7X
	U2mrQK45qJcK9AJk+cgLChJ1XIGsjTFitakJVTk/2vekW18bPB3GZ8Km25PFVs66U3opfRhR+6H
	FRLqXtyMVwXQAotyFAuJ3OfLDuW6sv5Dfvnj22YJ0Kg4Zk5FQ0Tid5QovSs+PIfzFcfrZWJkE4g
	==
X-Gm-Gg: AfdE7clwp6pMn4uqkVtiyxLtEcOUUJFQT1Dzsa8JM0QLtZ43V7G/iz/rRPhhO4qMakL
	sdhfbyk53nSCmV1Tgc/viI5reQLB6WH+qSQ9Tcynzoc9u8LofkWMX6q6O6aOaDiAomKhF2NF+Ic
	Gts+2bQID0rVKOrz0gEHtyatlmdjo5ePKj2+NP6Ikj8T90wfXTwcqtGUyhg3JehlPCKQ2xHIMwO
	kOP0DbUYEZBQBCfJcG9ZAxyu7g8MvB3MvBnt0Q80PB5yuwWiFg3CohfpBLU6DrVkCeH/uDLf7/h
	w+YxBhLp3uYXoG0NSWQ92hW9YJLPaNQN2gKVWjzY8bUNzgRkKfUB4r+bKc8BdDYySQMlc/kSl9B
	zoBVUKcD3GhFKA4o=
X-Received: by 2002:a05:600c:3112:b0:492:450c:57cf with SMTP id 5b1f17b1804b1-492450c5d26mr10997665e9.31.1781859177417;
        Fri, 19 Jun 2026 01:52:57 -0700 (PDT)
X-Received: by 2002:a05:600c:3112:b0:492:450c:57cf with SMTP id 5b1f17b1804b1-492450c5d26mr10996985e9.31.1781859176996;
        Fri, 19 Jun 2026 01:52:56 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd21dbdsm49886415e9.6.2026.06.19.01.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 01:52:56 -0700 (PDT)
Message-ID: <a7c658db7f3dc9fbee0ee2983a5343988a375f35.camel@redhat.com>
Subject: Re: [PATCH] rv: update rvgen monitor synthesis documentation path
From: Gabriele Monaco <gmonaco@redhat.com>
To: lucayu.alight@gmail.com
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Date: Fri, 19 Jun 2026 10:52:55 +0200
In-Reply-To: <20260618-rvgen-doc-path-v1-1-9bcf0148417a@gmail.com>
References: <20260618-rvgen-doc-path-v1-1-9bcf0148417a@gmail.com>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KemiDvnLaBmpbggoGh_iFMAh2qCW3fYvk9jpRltZOIo_1781859177
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-06-18 at 21:45 +0800, Yu Chuanyu via B4 Relay wrote:
> From: Yu Chuanyu <lucayu.alight@gmail.com>
>=20
> The rvgen source comments still refer to da_monitor_synthesis.rst,
> which
> no longer exists. The documentation is now available in
> monitor_synthesis.rst. Update both references to point to the current
> file.
>=20
> Signed-off-by: Yu Chuanyu <lucayu.alight@gmail.com>

Thanks for catching this!

Acked-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/__main__.py=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0tools/verification/rvgen/rvgen/dot2k.py | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/__main__.py
> b/tools/verification/rvgen/__main__.py
> index 5c923dc..2a2bb03 100644
> --- a/tools/verification/rvgen/__main__.py
> +++ b/tools/verification/rvgen/__main__.py
> @@ -6,7 +6,7 @@
> =C2=A0# dot2k: transform dot files into a monitor for the Linux kernel.
> =C2=A0#
> =C2=A0# For further information, see:
> -#=C2=A0=C2=A0 Documentation/trace/rv/da_monitor_synthesis.rst
> +#=C2=A0=C2=A0 Documentation/trace/rv/monitor_synthesis.rst
> =C2=A0
> =C2=A0if __name__ =3D=3D '__main__':
> =C2=A0=C2=A0=C2=A0=C2=A0 from rvgen.dot2k import da2k, ha2k
> diff --git a/tools/verification/rvgen/rvgen/dot2k.py
> b/tools/verification/rvgen/rvgen/dot2k.py
> index 110cfd6..326984f 100644
> --- a/tools/verification/rvgen/rvgen/dot2k.py
> +++ b/tools/verification/rvgen/rvgen/dot2k.py
> @@ -6,7 +6,7 @@
> =C2=A0# dot2k: transform dot files into a monitor for the Linux kernel.
> =C2=A0#
> =C2=A0# For further information, see:
> -#=C2=A0=C2=A0 Documentation/trace/rv/da_monitor_synthesis.rst
> +#=C2=A0=C2=A0 Documentation/trace/rv/monitor_synthesis.rst
> =C2=A0
> =C2=A0from collections import deque
> =C2=A0from .dot2c import Dot2c
>=20
> ---
> base-commit: e771677c937da5808f7b6c1f0e4a97ec1a84f8a8
> change-id: 20260618-rvgen-doc-path-11695c57153d
>=20
> Best regards,
> --=C2=A0=20
> Yu Chuanyu <lucayu.alight@gmail.com>
>=20
>=20

