Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B963B25782D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011431; cv=none; b=qvGFDYzTyL/jAt4XJgxy2SYJLYFHjfVSYQVvRcaBrRB9IasbZ6+TIGs7pQB8Xyzh0N5VrPeSVzKRLwb+o8INIa6V7MyAVqDZFb+PD0BWiSWJ19XHPypFxiVtp5aA6p7S+ySZCnpoahPUUtLh7lGREZemIJMSFP74/IPjULm62Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011431; c=relaxed/simple;
	bh=nnUaft89nRJr5fVcAq7DbmcTu8tCdDZEONhfsxqGM+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcYYSiiFS+o82DaHCP0B+k7276VXH27XBOulao3DjBoaTKpofWi4zCeLBadsNHXUb6rZBzmzMxOmwJYJOw3bQJoQLpjFqLLhhe2cCEZeP/sRLs4cF5OtWnjPRBdOQaID19eTNc4GMDpXyWuP1z9p653DhIybPKrMA5yVNuu1Hk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbBLs/l2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbBLs/l2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781011429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnUaft89nRJr5fVcAq7DbmcTu8tCdDZEONhfsxqGM+M=;
	b=LbBLs/l2Wp2iVTRnIwpO1yYkRPpLqKb/ofxZ3H5x/lXXFVaWGSz/KnqSXTd4wJy5nKDd9k
	22y5gYk8kdmdGSIcJmkp+UdjuqrJyrY0JLpzj/NnSwhNCgpUO2oPwKyF5sRe0FQDVMNnqO
	/7t2wSAzySs09N2EszJOjnt7f0hZi/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-X9i8HiL0Ocqdl7HMy9jVDg-1; Tue, 09 Jun 2026 09:23:48 -0400
X-MC-Unique: X9i8HiL0Ocqdl7HMy9jVDg-1
X-Mimecast-MFC-AGG-ID: X9i8HiL0Ocqdl7HMy9jVDg_1781011427
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490d3f03883so10743345e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 06:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011427; x=1781616227;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4t17tIbLOLm8EKJlVmoU1gMTEtKxq3C+GwnW5YMgPDk=;
        b=qVUOgFdag9Tv+7SF1pAkHnu5Jx38Dz9GrE12jJSbw4guo8rvuPfKYmvSAMWmfNePiZ
         yFe7BeBq51+GZTIHafJzXe1HV0hi10Y/qKr+OxqU2ZxMacUXz+Cfu9cRzTx2Pwbbe+mj
         Svv93YJq/YmgS3h8bMOhpMgM/3PO83zAiegA/mD0dGlIz6DN3QEBA3gb7ye9L9C4z+I8
         roRladPqp0dOgG7YXCY0cHDflS8bBElIJ4bi8JMqeHX6DkjSDj1Eh9LnAVTc3RBX+syC
         wQkT+3bX0rH8lQsCit20mazKQQD19lNUbEOgskPBCv7qUK7ZFhkjkTP1cnipWFEjk9D6
         f40A==
X-Forwarded-Encrypted: i=1; AFNElJ9iJbn3RG8VzjGdnHCJg1kNlUASwGGDSJsOUiYJE9sx5ga/on5gvAClGSuwMsektpFQZ/F16AyXWHfdzdAgjjC9WoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqGfQ7GLrcbvKDHBuHSUH6fVgqdyk7NXtL5NJFCXVUc0Xh4oCc
	vJVaAs6Gql5vHnQjPwKqWR7H+s9tEhNVaPHKG7HN/JmFZGgfzyE7yLCH7NscbJz4vJJIt7uKHZu
	OS2tMqn4uwwzzxiZ6dj+6pyZxwnvL5NV4jte5oPALa0phUHoNMCflzhzreX81fWMFqoIQUOQrBQ
	==
X-Gm-Gg: Acq92OFM2pch9a/HQhp+V/BVOBz1O8eN3VPg7fnERdL1INMNILsySC+iInTN56fAYJJ
	WE422KfUS5xOBWi9fsPFGjZZmNacXvi9aFhCunBD0rNuxS+AK9r1n8y5zEzLQO8UArm9XpNjf6j
	K6klN5yBA1CwRbGJUd+gLeqgYCa+57GR+vD3c3jAr7PQuwpgx8TOzH+ouzSnWiu9sMXCzMDtgEt
	4PuzaXxaW0cB05EU9lNvFV8Au0YaCTnwr/624AlAgXhXrBy4GQdIaFFcrxVqddeJkbtlAN7+J7K
	G8+dVN5IDNAjns+WHk01Z78xwL3+4d2JRujy8obedCMsK54Ql78bKzQYVGdx3knfn5OU5uFpYvU
	Qqaf3W4sU2IyGFO9o/dRenWPkOpR+G74KVuHf
X-Received: by 2002:a05:600c:4e45:b0:490:c01a:5f10 with SMTP id 5b1f17b1804b1-490c257f8cdmr337591235e9.15.1781011427112;
        Tue, 09 Jun 2026 06:23:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4e45:b0:490:c01a:5f10 with SMTP id 5b1f17b1804b1-490c257f8cdmr337590415e9.15.1781011426595;
        Tue, 09 Jun 2026 06:23:46 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39e024sm641961975e9.4.2026.06.09.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:23:46 -0700 (PDT)
Message-ID: <8a6bdffa673dcfa2df269b1e9d55f093ac4c7394.camel@redhat.com>
Subject: Re: [PATCH v3 03/13] verification/rvgen: Implement state and
 transition parser based on Lark
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 09 Jun 2026 15:23:45 +0200
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
X-Mimecast-MFC-PROC-ID: w8zSz7ylvU7jNKJm2utr_GdnmtEm0-ARLg2dTrwi4zc_1781011427
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gTW9uLCAyMDI2LTA2LTA4IGF0IDEwOjU2ICswMjAwLCBOYW0gQ2FvIHdyb3RlOgo+ICtjbGFz
cyBDb25zdHJhaW50UnVsZToKPiArwqDCoMKgIGdyYW1tYXIgPSByJycnCj4gK8KgwqDCoMKgwqDC
oMKgIHJ1bGU6IGNvbmRpdGlvbiAoT1AgY29uZGl0aW9uKSoKPiArCj4gK8KgwqDCoMKgwqDCoMKg
IE9QOiAiJiYiIHwgInx8Igo+ICsKPiArwqDCoMKgwqDCoMKgwqAgY29uZGl0aW9uOiBFTlYgQ01Q
X09QIFZBTCBVTklUPwo+ICsKPiArwqDCoMKgwqDCoMKgwqAgRU5WOiBDTkFNRQo+ICsKPiArwqDC
oMKgwqDCoMKgwqAgQ01QX09QOiAiPT0iIHwgIjw9IiB8ICI8IiB8ICI+PSIgfCAiPiIKPiArCj4g
K8KgwqDCoMKgwqDCoMKgIFZBTDogL1swLTldKy8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAv
W0EtWl9dK1woXCkvCQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IC9bQS1aX10rLwo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8IC9bYS16X10rXChcKS8KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCAvW2Etel9dKy8KPiArCj4gK8KgwqDCoMKgwqDCoMKgIFVOSVQ6ICJucyIgfCAidXMiIHwgIm1z
IiB8ICJzIgo+ICvCoMKgwqAgJycnCgpPbmUgbW9yZSAodGhhdCBzYXNoaWtvIGNvdWxkbid0IGZp
bmQpLCB3ZSdyZSB0YWxraW5nIGFib3V0ICJqIiBhcyBhCnVuaXQsIGl0IHNob3VsZCBiZSBhbGxv
d2VkIGFsc28gb24gbGl0ZXJhbHMgKHNvIHdlIG5lZWQgdG8gYWRkIGl0IGFzIGEKdmFsaWQgVU5J
VCkuCgpUaGFua3MsCkdhYnJpZWxlCg0K

