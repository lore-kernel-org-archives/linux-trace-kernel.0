Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D2236C0DC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390733; cv=pass; b=lAxaNxSGpH+JMMlMY6MG6unC+rTboq568EJWajbCabzAHxHhU+w97OU6vWUBzWmD8kNIJ00OELQGTaKAl5adZqlPDbs6WuHHt93m0EmVKw5S+xHhYKbS6Ywe5gptku/5hcdB+Hk+p0sFqiXGBNvnCGMpaEOAMrq7/mJd3wLs5fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390733; c=relaxed/simple;
	bh=73CFgCEKHFJELY9UP5/RhebVFajDLrcQrE0lsXPbdIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2YbTeYjV9XBo3Nh81hhasHFf3BdU2Om53Phg1Dh6w/pXZ2Eq/XhRBFldkoYClgvIgbyzyKe50DI6prhbNSzYggQGYL4HSgT/Q0WaBtsgM7yzLwA4NrsnxcZ9as05YOAX9xsPaw9x8vZTufoeC8a44YTu5c0ltASeK45V1oqcMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQJMmXtD; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQJMmXtD"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-509069a7a7fso391391cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 01:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773390731; cv=none;
        d=google.com; s=arc-20240605;
        b=EatYob4Y/imSYDahfAoHmQ5IATQf215rlCBswjlEEO0e6VJjNwr6iLZsoYWP+vc7Eh
         OTDJxZcAf1GlkHr5Snvj+OxsR7A/zdeYf8iFh1NHswgIBRo2BgUcHLgiLjDJbu7OYXcl
         jWZYm5QlM5Q9lbMbEqgEjmJV3/jnpjL94+aw55JY96+U8ZcnpqMfLtK0YOYM8K+4IRhI
         OGCJWRg4EDGhI33gA/CHxsmEkr4aWfCtnAsAovdGugkR0Few6Ln+VFjjIfPsFmlTBOuX
         WNQL7pmCMAdiHyydLnu9oYyTnGU3xBnonbzYY8AiF0aeHUErrqABgCu5Skcwyw4Xi/bg
         GIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+ZginHenLFfV4BXN5/Mah3uAKtVZ/csIYirzOzG2w24=;
        fh=5kM3C1tlatpRkNTgKyqbrL5z9js1kzJ2urB0JZSiMho=;
        b=kTe+te8OdTYBI28tc6b5/pVeM2oSh266aTQup2AZl27+j+T80u5ZtaBazYs+7mGQn6
         oyePFu2Y13Eiz7ukC9Ny7sZcCfBMvwHoj5pMp5QSpGQUuoXgxY3e5zCUrXgMqBayrlxf
         gf8EjgiO9m5nW7USnNlkOC7H9Jbf93y7tMAt1d8gphHjCg9iMCDlTNqIvA4BqWC4jruS
         u1PyW1nQNKIudjoFO0hESTLwn/bBJ7ambkoFFCrNZIp1IWJiGpk4X9eqZJOcCIcF+6y3
         /ZqEkvxigT5vJXaZxnWfLwVP+5AAZEPzKkhfYRr038nzex3YhBeCkStSPRwNLv0vdQk3
         Gq7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773390731; x=1773995531; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZginHenLFfV4BXN5/Mah3uAKtVZ/csIYirzOzG2w24=;
        b=nQJMmXtDeSbfqyR+LkB3F6MP0abezHJlWnsMbWoEcXY08iHzHCjQhwLMn8VR4iT2Be
         G1UgMm5hGMR3gYMYgmgkeR25dFtszddTUZNA8KbWejU6Qg0bU6y5QU4ORGPkXuJSWgdL
         qF0bNUYpsGBcQsDCD9VCFAx8lIRtDxgdSh9W9HQrqGJFElIOD/TzbthIFloS0wM57u0Z
         quzVdUomwO1CWThAvGKXHVUhtRBgezKzUsbQRN2pRl9u8QU58pk9XVuVvuJUsevLO37B
         /2oUkr+FqlOR2zNGSgeYYq3id7E/zCJFtLM+z9d6ojL5T/PvKBMvtY9I0pHKEDDVyg/a
         +l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773390731; x=1773995531;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZginHenLFfV4BXN5/Mah3uAKtVZ/csIYirzOzG2w24=;
        b=Ui99C6ErpGaVy1uXghs21hMzns/gb2zj4RF3Qo7kZ0x1x1h0+5xG7YUS/MZ8T2PN3U
         tZlu9gdQDbeOx6FlqjtPgnpMiO1FotXm9g0nk55xxwAga6g6Dun86FMc7TpZQsuVIKzS
         p4GwmOlYbLiBf1UfwDUL3pkEHB6Z40d6qVygRY15R/Xfv+9LBT+aorj4G421JGCR7oUG
         mm+1lIk7QgRlmGZVlsCLAaJhytEv32wU7RNnPiKPHHqjuXzOKLjKpNULRrHGEvrHL/F+
         bMmRLtDYddsA7Xs85fVpXri8lTnKaU+2F0ZtTW/lZUszkfEANhKB6Dj0odOvJ/MrmrxB
         Ozsg==
X-Forwarded-Encrypted: i=1; AJvYcCW4HYc9C9pewHOlEqy/jlDRfIeWM0D549FxNl2WGonfpHuPDAZSMaajqEZPUL/ICqvE57iQPbAV6jLwau4ziqkovSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgy26zvmKVe6/Q7PcthKAsbA6wvj4jlIbbsnSG73LEk8eAnmQX
	QYTBUD+jhwVYn0EO3hHSmIb79Jny2VzqXcccYCNqlkKO+iHSx/RZrRJe/W4LiHtPHoWsgdcSJpq
	qRAH4JYWwfmpKdeCQGfnvSm8UNFwghGOY5IU2YCTu
X-Gm-Gg: ATEYQzwx3k51ZFANZEs2LxQoGBubGhHEM7W/yWRvfpcdFFZpqt4f06sivBc69eWpuw2
	e6D+YQt42ip9yTIWSLjiJDJduVyiZinBX9rqnMwR661H/+o9NebePw4glSt4ueZ4c90cvr8lHTx
	fAbXHKV0L3LjVQyrIUrCfGV7RwUGO4NHylW6Oq+Tb1YdUwhzXWu5/hyhavfQ9XLv73+hMkIydov
	B9dt65+mBFSYw9BGwo+mfQPh3Uq1WhRRsEmmy1sn5zkw4o4EkGMJvQ7BlQHSmO7NIFe3Swbdg2F
	1qn08pjC
X-Received: by 2002:a05:622a:58c:b0:506:9852:75ec with SMTP id
 d75a77b69052e-50959e1d20cmr8206111cf.9.1773390730313; Fri, 13 Mar 2026
 01:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
 <CAEvNRgG-L+GBcm+u_thGvXAxV-Nqzu5VtgXy0PfND6SG0FiyVg@mail.gmail.com>
 <CA+EHjTy2urW2Tj5czQDKUHdri7FCLfw2mafTgmmtFs+-7ueoiw@mail.gmail.com>
 <abLfWHf89TxWqeGZ@google.com> <CAEvNRgFUc+9xCoN9Yo5NThHrvbccWAhPwp9nNM2fvx7QqrcJsg@mail.gmail.com>
In-Reply-To: <CAEvNRgFUc+9xCoN9Yo5NThHrvbccWAhPwp9nNM2fvx7QqrcJsg@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 13 Mar 2026 08:31:33 +0000
X-Gm-Features: AaiRm52mXTtSsie7DL9lVs7x2V-5c-a3ZmVbxJyJb1VBocy3h5inh1iSGtq73Is
Message-ID: <CA+EHjTzJmJZF=XE2NWsTZ9yCVix8oLp6M_Jb5m2EuC-W5p+U4A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Ackerley Tng <ackerleytng@google.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chao.p.peng@linux.intel.com, 
	chenhuacai@kernel.org, corbet@lwn.net, dave.hansen@linux.intel.com, 
	david@kernel.org, hpa@zytor.com, ira.weiny@intel.com, jgg@nvidia.com, 
	jmattson@google.com, jroedel@suse.de, jthoughton@google.com, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, shivankg@amd.com, shuah@kernel.org, steven.price@arm.com, 
	tglx@linutronix.de, vannapurve@google.com, vbabka@suse.cz, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Ackerley,

<snip>

> > By default, KVM makes no guarantees about the in-memory values after memory is
> > convert to/from shared/private.  Optionally, userspace may instruct KVM to
> > ensure the contents of memory are zeroed or preserved, e.g. to enable in-place
> > sharing of data, or as an optimization to avoid having to re-zero memory when
> > the trusted entity guarantees the memory will be zeroed after conversion.
> >
>
> How about:
>
> or as an optimization to avoid having to re-zero memory when userspace
> could have relied on the trusted entity to guarantee the memory will be
> zeroed as part of the entire conversion process.
>
> > The behaviors supported by a given KVM instance can be queried via <cap>.  If
>
> I started with some implementation and was questioning the value of a
> CAP. It seems like there won't be anything dynamic about this?

We can drop the CAP for now. Probing via the ioctl and handling
-EOPNOTSUPP is entirely sufficient for the VMM to discover whether
ZERO or PRESERVE are supported for a given architecture and conversion
direction.

> The userspace code can check what platform it is running on, and then
> decide ZERO or PRESERVE based on the platform:
>
> If the VM is running on TDX, it would want to specify ZERO all the
> time. If the VM were running on pKVM it would want to specify PRESERVE
> if it wants to enable in-place sharing, and ZERO if it wants to zero the
> memory.
>
> If someday TDX supports PRESERVE, then there's room for discovery of
> which algorithm to choose when running the guest. Perhaps that's when
> the CAP should be introduced?
>
> > the requested behavior is an unsupported, KVM will return -EOPNOTSUPP and
> > reject the conversion request.  Note!  The "ZERO" request is only support for
> > private to shared conversion!

I think that this makes sensefor the UAPI. Returning -EOPNOTSUPP for
shared-to-private ZERO conversions.

For pKVM's specific use cases where the VMM requires a zeroed page to
be injected into the guest's private space via attribute conversion,
the VMM can simply `memset()` the shared memory to zero in userspace,
and then invoke the ioctl with the
`KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE` flag. This completely offloads
the UAPI from making guarantees on behalf of the trusted entity, while
still satisfying pKVM's functional requirements.

Cheers,
/fuad
