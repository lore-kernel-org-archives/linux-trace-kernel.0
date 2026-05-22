Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A0400DEC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 16:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466074; cv=none; b=M0rsBHjPcz4zv/bwle7RXX8BqABrLdCPepEkbs5bCJ0BBOfssP49AEszy3W3s+kC/XY0jTxKc94jLHB5h5wdlXjgyWFBJqulKNr8tlx3g246Cj75mfMxKibY3jwCbIKnEfgR1HaPIXPExUIirbhKywbiRxiYHKNj4kYM80i5DF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466074; c=relaxed/simple;
	bh=Z7CZniyudQvtGykBjwFqflJux61iIz/Fi25N4Y0qOJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueNlbszRyI1iqBUwxTH6VDDSG9USyk50NHl0skCEIO0Etl+AxUn7fuH8rL+iUFqnwP00X4JwmslAIuZqNSbk5OFEbNAJSWhT84l5T83KM5vhMkMumC7f4ONehfhpPu2WOED6V9ZYdHBigewk0yCTnYvSbkd2aC/+Xvr0L1xnTu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNl7Q6/b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNl7Q6/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779466072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7CZniyudQvtGykBjwFqflJux61iIz/Fi25N4Y0qOJI=;
	b=PNl7Q6/bpFzjlNljoTdLqlnYTmyofZ5nREKlsDKT9jic1gkPoAQ6vx5aRIeulfzIScIUNX
	A5WXOwfWT243UwsTXJgx24rip3fBryDqCQ8lQHgx9HdStqTwupnJj3OwVOyghiMWcZ0Z4C
	RxNfkDjbJswHqBOSSc91RYNo47Epgto=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-QPEug8sZMeGc3MqN37aSPg-1; Fri, 22 May 2026 12:07:50 -0400
X-MC-Unique: QPEug8sZMeGc3MqN37aSPg-1
X-Mimecast-MFC-AGG-ID: QPEug8sZMeGc3MqN37aSPg_1779466070
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-65e1b9f1ebeso14670354d50.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 22 May 2026 09:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466070; x=1780070870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z7CZniyudQvtGykBjwFqflJux61iIz/Fi25N4Y0qOJI=;
        b=sn7yuOhc2EadBpnRM3NNDQVPKHYK6gMidKTRUetES29ZIPmxHs/72gVRxmL8UbpdBp
         31fgU4niWLxWVP6oXQhl3pqUDBIr3/y8m0F8ycO0zjolPglfX0gNh/x6v3RZG9So97DX
         S9mhhVjV5yC7G/5tNw2hdNDuCA8BLagqK7r0GFFrj/u7B85ckdzc9AfRsuyaN7lb4j+z
         kI4Qk2qHE8JMarS8DQNjJh7gnGae/thoViJUgL9wFMzgWKFrtehhIvyN/uNAmoIeHSTx
         NOyLYfri5/tvLc9W943ViofGqJB7EtqJGeCcmP4iZkxLs1MQTnlBIJkmOLHw6pgR/7Dc
         5rtw==
X-Forwarded-Encrypted: i=1; AFNElJ9WHqbcJe76SUbH3JfWtPglgicBRsEaGVY//6IJk1/lYRJeJDBZHIXptwD6/I243n9CwrlSHCysq8NcQZfAx4m7G+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YysW7Ewt+5ouPu34EQxAs+zLvwDHzStP7fz1nA9KLqsJf3FjKbR
	2JLqpKaU2XCizFcZe1Vni7sWL3lYiXXcyGogCracOtStQC7l9fVXXC0uGFV3gX4fvDc1vqChEIe
	PwkwEnnwFC4C4N8sPXTvX1EFh7kJj7XwzAKs/oYM39fhCHCVGM27Pm2vKYysps2npwqBjaXoGsA
	pZ2TSed14pmI5fGSBj/gkWpHXUn9aRxOc5xfMwRRFJyjWH1E82
X-Gm-Gg: Acq92OFpCC7b5GdresOw+i1rdvQ8eIFhdFQLC4JsvbkToxwPa/9OLwK+ZeiitdgPyWl
	o947Ymfw1CrsWfoHgR65BBUzYsI5d6j4TAzaMklqZHWBXv5srOTisLTeQ0dFRvFrl0FY89GPygj
	5+07PnwvJxxjxf6JEIFe8Lq+yGFCl1jDk89lymDt4A362eNQAqoogN3L1tq4j/uxTs+7vOUCz2u
	+oFIQ==
X-Received: by 2002:a05:690e:1284:b0:65c:74c2:31c6 with SMTP id 956f58d0204a3-65eca654410mr2973369d50.5.1779466070081;
        Fri, 22 May 2026 09:07:50 -0700 (PDT)
X-Received: by 2002:a05:690e:1284:b0:65c:74c2:31c6 with SMTP id
 956f58d0204a3-65eca654410mr2973309d50.5.1779466069568; Fri, 22 May 2026
 09:07:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <CAA1CXcCoDU_pnp0SmMzRi8wPGB1OBjbbokevq2X_03X1vpWtOw@mail.gmail.com>
 <ahByO_HWn6MB8z-u@lucifer>
In-Reply-To: <ahByO_HWn6MB8z-u@lucifer>
From: Nico Pache <npache@redhat.com>
Date: Fri, 22 May 2026 10:08:19 -0600
X-Gm-Features: AVHnY4K-NMEYaoOF8CwzqrbGVrRxOSsC61YCW8vw8BzLOXMR_M4k6Y4gQwbZHRs
Message-ID: <CAA1CXcDoFdZZ4aBx0BPA7QXYKYBYDoqUiLTLYe3L5opJ0LsJGg@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: linux-doc@vger.kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, 
	cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jack@suse.cz, jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, 
	rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OR6WZVI5ZtBbnM9b1stoqUxxTxXuZ5szq_ddttjutac_1779466070
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 9:17=E2=80=AFAM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Fri, May 22, 2026 at 09:07:29AM -0600, Nico Pache wrote:
> > Whoops I manually changed the coverletter subject to reflect that this
> > in on mm-hotfixes-unstable but never updated the others...
> >
> > Hopefully that is ok. Just a small mistake. Base commit is referenced h=
ere.
>
> It's not ok, this isn't suitable for a hotfix in any way shape or form?
>
> As you know, because we told you :) May has been difficult because of
> conferences, holidays (and in my case burnout recovery).
>
> And unfortunately the series seems to have needed quite a bit of review a=
gain
> (my suggestion to you would be to ensure you don't make major changes, on=
ly
> small incremental ones on the basis of review feedback).
>
> So this isn't viable for 7.2, and we'll have to target 7.3. Therefore the=
re
> was no rush.
>
> Also please don't spring a respin on this series on us without discussion
> first, with people away and (frankly) the amount of work involved here,
> you're going to have to accept the pace that workload/availability permit=
s.
>
> Adding spurious hotfixes tags doesn't help anything :) please don't do th=
at
> again.

Hi,

Sorry for the confusion but Andrew and I spoke about this before I
sent it, and he confirmed that I should send it against this tree to
prevent merge conflicts.

Because Zi's series depends on this, and this is already in the mm
tree, choosing a candidate before my commits was best to prevent merge
conflicts.

The intent wasn't that this is a hotfix, just that this was the
closest base before the v17 that is already in the tree.

Sorry for the confusion, hopefully Andrew can still apply it to the
correct tree.

-- Nico

>
> Thanks, Lorenzo
>

