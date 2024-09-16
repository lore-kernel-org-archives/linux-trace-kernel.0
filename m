Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5021509B3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726486541; cv=none; b=Zbr/A6MUsdEqV5kjLHfGsmUjj/weUIP+bi+l46b4K/amu4uO1Lm/hwid2EYh9VCGMMZcEGsRnZOM1Z4+IN0OgB6BXTjgKCdHY4VNPFy0vjXAahg4lEwm2pinsO98ErIf1Z1YMxBjiHR0uVFBy/19BDx7D2HLbWKB1nxmeGCtTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726486541; c=relaxed/simple;
	bh=5jwxVrOprPXwZylwnhBWef7J0StTjKelVFOYMyVV1Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+//Cq2ddYcYYmtgqZs9FBS+ttRDnFzN9BiSyJd5TRwdTmmDgGQUQsiBDxVXd326NMFY1WeMMvPhk0sNmDdTgYUnDWkRa2y1/eYq/lnaDVhRdq6obKg50Fd1pICIFIMjzWW81OgyPDT6njU28rxJN2/v/mdCxdc63zilE3jLOeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVcEZm9y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVcEZm9y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726486538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3QVMgTGnO9b909DFFoiiE8HCm96W/gLeP8Iw/Hs+Ls=;
	b=CVcEZm9ylj27hVYRW20Z6kBeBOxKVGOUcG9EEGYNmg/7apw+OVmtrynASwRM+1IyS+CSOQ
	b9P87xyJ/aiQQQSmDvPsvvqrU5M5+yOoydeXr49wVVpi/NbEl4Dsx5xg5V5lDJvDqExx2O
	bPUUztVusq9BtyHnObp0/nJY1WHcXv0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-umv28JT_PbaSAgvkHWL8Jw-1; Mon, 16 Sep 2024 07:35:37 -0400
X-MC-Unique: umv28JT_PbaSAgvkHWL8Jw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f7586de61cso30565911fa.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726486535; x=1727091335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3QVMgTGnO9b909DFFoiiE8HCm96W/gLeP8Iw/Hs+Ls=;
        b=IibDKUGV0wBV2ySoOOITLn3jxhpbt7CihTYQm3DXxmEwCsU31mv6+2VIt2pgIaXMMg
         iok2VOen/J3Evr6lKCSiCy4H9UBTfsOXL80/552lZTkt/af4dku2Ny1/oDgKhvghjqut
         y9ndYTezKeOZ5f9vktXenln4ufYHiS+X1y4JB13SysZyPt38a79TxENeRrRxI8DYFFiS
         B5YfDra84jgRS2e3IQX1y2XQHvCF6HNTx30jr1ubE25R+e2C4QJjNQmF1Er8iEcenpOj
         drfgkDAtxgNCM4jpHrvgTS/e1iPKvG14lmqllC8dr9UP/OGISEvpG+42BZxEU2z84Zr1
         ZgYg==
X-Forwarded-Encrypted: i=1; AJvYcCWMuo2FyTgoap3I2QqsG2gZNEjL/L460BuTiGJDJyKzSGWJC07IMXIoUXjwGWPWUSc1TFmdeIFkxOcIp58duPqvBao=@vger.kernel.org
X-Gm-Message-State: AOJu0YznS9BR6ZTshq6FG3vq6sOBJDFo9b4Z3LL09FqLsoD07o95R6KD
	LqVHTsWOeV3/TVbE2nAA2puFWsy3HJGtsPRzWlNUhL/RKbUp9jStMOZv7+0sZ/amY3KgBOteOL/
	nDFQ3r95cUNx0texNwXKPfDghyeAHFyMhPa9DXazcnoIsczMB+fNrqFMsvP1RfPCkoN4yPz6Abf
	5fUUCNoSNXEkNi+6b5AHPU5zvPDjVPkBUa+tZ0ZbkbsFPEoG6cBb1WvIU=
X-Received: by 2002:a2e:a987:0:b0:2f3:d8dd:a1f6 with SMTP id 38308e7fff4ca-2f787f505demr83661801fa.40.1726486535355;
        Mon, 16 Sep 2024 04:35:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6CSxrzT464fV72MMffGrlf0jQbKHcn8dF9X9wJmAzwuOQ0VqncHoFjWQ5J/96Tm60Yr1tcTGVaCtaOiV08y8=
X-Received: by 2002:a2e:a987:0:b0:2f3:d8dd:a1f6 with SMTP id
 38308e7fff4ca-2f787f505demr83661161fa.40.1726486533908; Mon, 16 Sep 2024
 04:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZudubuoU_JHjPZ7w@decadent.org.uk>
In-Reply-To: <ZudubuoU_JHjPZ7w@decadent.org.uk>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 16 Sep 2024 13:35:22 +0200
Message-ID: <CAP4=nvT2+0aMnKJnRqPGGS3XfzYDH-uwcgt5++Ek9v8wLkWePg@mail.gmail.com>
Subject: Re: tools/rtla: Fix installation from out-of-tree build
To: Ben Hutchings <benh@debian.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 16. 9. 2024 v 1:32 odes=C3=ADlatel Ben Hutchings <benh@debian.org> napsa=
l:
>
> rtla now supports out-of-tree builds, but installation fails as it
> still tries to install the rtla binary from the source tree.  Use the
> existing macro $(RTLA) to refer to the binary.
>
> Fixes: 01474dc706ca ("tools/rtla: Use tools/build makefiles to build rtla=
")
> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
> --- a/tools/tracing/rtla/Makefile.rtla
> +++ b/tools/tracing/rtla/Makefile.rtla
> @@ -38,7 +38,7 @@ BINDIR                :=3D /usr/bin
>  .PHONY: install
>  install: doc_install
>         @$(MKDIR) -p $(DESTDIR)$(BINDIR)
> -       $(call QUIET_INSTALL,rtla)$(INSTALL) rtla -m 755 $(DESTDIR)$(BIND=
IR)
> +       $(call QUIET_INSTALL,rtla)$(INSTALL) $(RTLA) -m 755 $(DESTDIR)$(B=
INDIR)
>         @$(STRIP) $(DESTDIR)$(BINDIR)/rtla
>         @test ! -f $(DESTDIR)$(BINDIR)/osnoise || $(RM) $(DESTDIR)$(BINDI=
R)/osnoise
>         @$(LN) rtla $(DESTDIR)$(BINDIR)/osnoise

Out-of-tree install is fixed for me when applied on latest upstream
top (e8fc317dfca9 "Merge tag 'vfs-6.12.procfs' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs").

Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Tested-by: Tomas Glozar <tglozar@redhat.com>

Tomas

