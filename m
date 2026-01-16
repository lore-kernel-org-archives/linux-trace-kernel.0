Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143536654C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 11:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768563555; cv=none; b=Qmu8tfqhEsMxMDf7JjCZIzt9HIObE1DJ294recNeCDZWLqO6QlKvgpdFheDd1RfFl9gzC+SmSpYSoOnkWbdsG6n8u9DND7FOET81ZVUK94pptaNkD7tyP94PQYakMPw8JmLMM3L6Q3fNEX3ArldNXOjfnJJPoabA8LgEYNuXXog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768563555; c=relaxed/simple;
	bh=tgJim6hB1zWMV8KvYyrCnvmxAJ5H9/5bCqGIpPk10lI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tj1CtDiPfX3U4bGhQvou71SPdQf3zF39KsYqfkkjfYkGXhq6eMIjGok2kJ9bzeSx0MsPO9cPOacPw1vmEDg6Daq4vxI35vQH8TDWbqCPPUwCgYnxPbRNnf4syLZsqIG7b+ByPejopkvMOK6rowcbTfJmMxNQ0dzcxLBj1vk3jcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=id3g2Zpw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="id3g2Zpw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768563545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgJim6hB1zWMV8KvYyrCnvmxAJ5H9/5bCqGIpPk10lI=;
	b=id3g2Zpwn9paWSqGTN0N5/3HXGDAkitFPCELhs4RDObLwIbSIle4V6ig4Q84JUe7YzBV9V
	n7tqr4e1Hp+UN8pUSicp+FZ0f+Al1DFf4jZxz2TGbVWBC3dmzp40P7he7iYFiPwp62lOGr
	3DNP7+F4oFcOu4C/Wju0aZjLhbypOQ8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-2G7aPKVePjGPyjdA8qcI9Q-1; Fri, 16 Jan 2026 06:39:01 -0500
X-MC-Unique: 2G7aPKVePjGPyjdA8qcI9Q-1
X-Mimecast-MFC-AGG-ID: 2G7aPKVePjGPyjdA8qcI9Q_1768563540
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38317963123so12013091fa.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 03:39:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768563540; x=1769168340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tgJim6hB1zWMV8KvYyrCnvmxAJ5H9/5bCqGIpPk10lI=;
        b=dK7X+yh2fFNu3MyfFR+ZHd9W8vICMmHB+8MCIZYFaoSVVQOn3ktDziJBzgJegJYbB4
         Y55unC8zoyb0rJAy1Rl1thUmysDl6NbgUVM8HdDquvnGsJcmGiysNbhuZVlMQkeD2ORJ
         vrJk3gSEa/XDlwMUigZFyvZONikOwOj5nFINCjfr9Ahre5aubRYXyyM2yc0MOi+f2lz/
         bFXNtqIomqNC8SzGJ34GQkVy4PDv+BVygOEbAqaARXAbCzDdiPL/ZAumLiUoN+PaBzvH
         w3VSVI7X/3vUrS8Dtp/DJ8kAu28u+/6RrgrbMBerZMT41pf0WvmkxNLEFPFB6cdrwcQw
         56PQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu3kGOc1G1zRloTZJ1O0Fu6McPoOFe9TrfjIUYdz8djjfWu8+t3eW5jgHZ4NBUYWz0191aILL89xnfBqW+le6GKWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTwUmVkhTbUWwEs34EPYr3gP5JzcwGazlIqQAzrKNtO61iWoX
	QpBhLXKvCC1MdT7MlcFu/KeJFOU24aa9sF3+tI25qnP4eBqHoR/JENDlf4oa3idqQc66W5YXm2j
	yFGlB2dQzb5+HfqJEaq9icFtKtYipKE0pGGUBYNaAfXNFDxfCSonJUvd6EBSsOpleVnWlgUYCfs
	Etke4JtfYlnd6/JO6KN3i/MttGmkeiKQFOmJ9fcPQOwjxRoihI
X-Gm-Gg: AY/fxX6C2sIDu3rtzkl/neCtzsmSxCADp1AS5Uxt2Q3btNSifewVyLJAYq2YDdfsfGD
	KkpKTHUhu9p2RaBS+B1wEtvaOWvVU/P4gGHNkaDliJDzkWGoD1dq4D8nEcE9JG1OVLL55jsgPR2
	888wqHVq2jQqaeBP8GZySjpo6jsCGbfEJ8FlSz4JIYs5HK4tsNrayONzkiC5JWlWgwZ9lk4MRiM
	fNRvyhern8txDyuD4bs53suGlDqwAEYudfkL3hyc3uME8YZFjOIaSMynd8xxUmf3/NV3g==
X-Received: by 2002:a2e:b88b:0:b0:383:5ba0:946b with SMTP id 38308e7fff4ca-383841473e5mr8403381fa.6.1768563540256;
        Fri, 16 Jan 2026 03:39:00 -0800 (PST)
X-Received: by 2002:a2e:b88b:0:b0:383:5ba0:946b with SMTP id
 38308e7fff4ca-383841473e5mr8403251fa.6.1768563539835; Fri, 16 Jan 2026
 03:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115163650.118910-1-wander@redhat.com> <20260115163650.118910-4-wander@redhat.com>
 <CADDUTFzD6WTg8=b+4v+Rw_LAi7MmmVPPVqoSws9rZYksd5dn_w@mail.gmail.com>
In-Reply-To: <CADDUTFzD6WTg8=b+4v+Rw_LAi7MmmVPPVqoSws9rZYksd5dn_w@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 16 Jan 2026 08:38:48 -0300
X-Gm-Features: AZwV_QhPKPQvt7QplWF66df9610d4G1tzMhTbMFKHRmJT44PCxmqz3w_KIgAD2o
Message-ID: <CAAq0SUnszAF8HXK6Knve+V-r97otAxN2FnM-8mNt4Pvh79pFug@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] rtla: Simplify argument parsing
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Haiyong Sun <sunhaiyong@loongson.cn>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Daniel Wagner <dwagner@suse.de>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tb-NeaaFls6ZqUQz0Y5WhDdBX55EACO2DpT6RDX9EHk_1768563540
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:47=E2=80=AFPM Costa Shulyupin <costa.shul@redhat.=
com> wrote:
>
> On Thu, 15 Jan 2026 at 19:25, Wander Lairson Costa <wander@redhat.com> wr=
ote:
> > To simplify and improve the robustness of argument parsing, introduce a
> > new extract_arg() helper macro. This macro extracts the value from a
> > "key=3Dvalue" pair, making the code more concise and readable.
>
> Would you consider using getsubopt?
>

That's a good idea. But I would like to defer this to a following up patch.

> Costa
>

