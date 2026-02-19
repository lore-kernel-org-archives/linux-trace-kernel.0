Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFA3168E5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 12:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505040; cv=pass; b=qoPtKJXGtv1PZup+oFnfaDvofQM9/+kKpa81L42fcxPg6xz96NM1bEzjoIy+V1Xlv3keljDSivPKxez0DhdoUS3+h2AEOdziJWb5eC8j6628Xroy2ycUlxsxs70brwiQr1a/Ecx8O49GkDctTRpb4iGw/FR2UUYQAoW8bNj6uJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505040; c=relaxed/simple;
	bh=aes4AHs+AOWhWj2FYmgytAYSf1U9HD0Qri/K8EHmzMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SznnjMUodRYHhNuhVk2kQ86DSr/elOAKpo5xTVcotcqvOFJVP+f0tKYtNHPeyyzh5GJiRyidWnT+R/tb/Obtek6YEUEEcIBE1fGsEDbVVgZnKXLzrFGnB/Qg+DUwwuKsb8dBE0Skm3qZL0dz7c+Azulq+h5TpLcloLYZTVuS/DE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y2XdxYxl; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y2XdxYxl"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-505d3baf1a7so360001cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 04:43:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771505038; cv=none;
        d=google.com; s=arc-20240605;
        b=Kj/bUpiEX2K8w222CZRZyTP+frFgnn1clByfkBbi+Iq/x8io9kWKoU+GitaJXbCZkt
         osB3u/jW1860HkRol3qOym7A+II5/CKe70IU8OkCb7nOJWBfbYoH1Bdxy7p1jMN55+rc
         dOxaCa73l4tNyMfCdda1j4Y6oHqbRxcimgmQqu93b9m0Tugabhf+YlcBtAaWRDpEb1M/
         EkiugyFnp8w5tbGVLKOmiGc+bxnabImeIpGqYm3usjXnaUxBh9yfU2G/HQmQXMtRz4dL
         2lhVDwhKl/DDt8MsVTCeRUWLSsXW9YWBxNAz4vrLGE40xoLiKhE65XAoDfpYDUjmwxO5
         yHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=o9bs+Ht8G4EwUkix0oJqONw0G8EjLC3MyIbQ69wavOs=;
        fh=rUWVfqfO9XN+BF/G2v6uUIxXwwso0J1nqzIamFK+ZvQ=;
        b=VnrBmzm8z/p27/LT+33ecDwIpf/rf6E5YZnozQdfWKgpqFMTqr+3w08/wuomN+3O/o
         z+DCDoet5/ogbJI0M7kV1oqTfk5b4sh9L9903GwzkofrMfoixCSQDFAWJ/HmoUH3i8EU
         ROCKzNR6EsrQDLIrxghnOE09nc7Lmp0DcFOPgkllpgPIyhRUdng4ffgqFJfWtM/oE72z
         f1JljsgmnTcFUupVQgNZCh4X/yRRHgA/59I9n0DCONVc4dLzLgDbT9BM0S5KxXvHqUAU
         Ygjsn791PJhfW1fKN3jPLrV9AKeectemWjk+CjvE9vGQvGwSkyGc4rS6p6yv043UsWVJ
         R/Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771505038; x=1772109838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o9bs+Ht8G4EwUkix0oJqONw0G8EjLC3MyIbQ69wavOs=;
        b=y2XdxYxl5B3qEvIH/7EiyUej4zu02zEh9V+uDaCvJARejtyhqCZB8IMShpk9DVW4yg
         DTY+BbcwGWxPF5A4vAA3CZdXqDijVHjcjqmrzK45AiqlGN1BaKNePYguDXF6K9t/X9wI
         siW+NqVc+3yFrf5NvuIj3giYLezlvipPZWL53de5kU/mYRkiOEJX5yGiuvIUFAgjSrkJ
         DCYe77MNFT+sBHoglLREmJpBgpDHFrcfpTqkwuhBuUisth9R9C/dsWdbNnPB8QTh8+/B
         JAuqbx+v247CdBrVHzMIfB7U43HXT4ikfSJpeQ+wEzdYYmP7KAS5KmpLCz3Gc32hMh/q
         Fe9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771505038; x=1772109838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9bs+Ht8G4EwUkix0oJqONw0G8EjLC3MyIbQ69wavOs=;
        b=n3tSZn9OsJX0DyB7rdlHSGOhT3czqlPjwRYycgPPGMhtB7bdMtXdK+atjH6HSu8Cix
         48o1TRcd2ao8SEHmKlo95wvQg9xcsb63msJ+z8wikYpW0eeDKeoDyyYV+mxmtL4fyUt4
         VIPRyNgAylthHzobAHiKVWN38ABV0sBdXKJ+3lDlJb4upvfboOBmQk0vLnUUjCVK8r55
         N/QC1DCstOuIfwyjVzKzlJvgGP4FNQ6SHUtPq3pTkMwx72yPxFxfVVJL1i1msi5ftIlT
         FU8+TqxyWaKJeHVTIFeIb0PhBopqUcC0AganoxcQ9cmJ1+jMcXzMmatFhC/uHIvtuYvK
         dDfA==
X-Forwarded-Encrypted: i=1; AJvYcCVAEFCatHWiq7LzAy/Sllv1voC10pAX2fNSoQgC/N54mUupZSs9m+857BJcbR1VpVDF6bs6jAVWJnNxnCDc3u+3c5k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+QQTiAmPwAEMwKWKitWk6Z3hPzw4qWuPmnqHA2MWuOWdAvTZv
	DbmTSz6UUSUbKTdmfzyaUwDyVw7sRd2tnYle+TUtl+pZaMYUyc5okVJ3ViAFbQk0wLX2aZcUDNl
	3hs1Tgg1+QRUAMMJF++KUalA7gcdchcqnU9ycrnHG
X-Gm-Gg: AZuq6aK+XSWLzN+120knpkwUAZIicULB/0B5lSo1pXMnvOA9UQ+GhvfDjOU53HR2O5m
	XLFmIPT86rfi6XPzFR1tUvrnOPB0OqyUq1nTk9tsCfKrCUTsEwyhjeFt8P8Gpxe62MgFRjJEtKW
	RgNX3Z4H0OnNYpsqcVNCrKf7wtCY3Yp4N4BvFuLanl/TZOzrydESdNMVxe3EVH/acJWV3CIt6YK
	7oJ8E5wsvtowe2XAXvZ81HQMfdLxSeE9SKr4R+o8GkZ+ml9/hGp3+IvIrheObQMSE2KZPEXfO86
	1qMHCJqo
X-Received: by 2002:ac8:7f0c:0:b0:501:4539:c81 with SMTP id
 d75a77b69052e-506f1dbd2e8mr6722271cf.2.1771505037357; Thu, 19 Feb 2026
 04:43:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
In-Reply-To: <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 19 Feb 2026 12:43:20 +0000
X-Gm-Features: AaiRm52i2AVuoNuRooDCBFkBdqWWQyvSpL3Y8tHflFey7_du661FzMtD72y3RC4
Message-ID: <CA+EHjTwax_DW58a-hQ=TtsqbjTbBDBDeGvkL1fcDOnY4B-SjeQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Ackerley Tng <ackerleytng@google.com>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
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
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tglx@linutronix.de, vannapurve@google.com, 
	vbabka@suse.cz, willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Hi Ackerley,

Sorry, but I completely missed this!

[...snip...]

> 4. guest_memfd ioctl flag
>    SET_MEMORY_ATTRIBUTES2_FLAG_PRESERVE_CONTENTS. -EINVAL if kernel and
>    vendor don't support content preservation
>
> Specifying a flag to choose whether content should be preserved at
> conversion-time is the current best suggestion.
>
> What does the rest of the community think of a conversion ioctl flag to
> choose whether to preserve memory contents on conversion?
>
> Fuad, I think you also made a related comment on an earlier internal
> version we were working on. What do you/pKVM think?

Introducing PRESERVE_CONTENTS seems like the correct architectural
approach to me. pKVM fully supports requiring the PRESERVE_CONTENTS
flag on every conversion where data retention is expected. As you
know, pKVM operates at EL2 with control over Stage-2 page tables, so
we intrinsically support in-place state transitions. Requiring the VMM
to explicitly pass this flag when injecting payloads ensures we have
explicit userspace intent without artificially restricting pKVM's
capabilities.

If userspace omits the PRESERVE_CONTENTS flag, KVM must zero the page
contents in software and proceed. Returning -EINVAL would be incorrect
because it would make the flag mandatory, eliminating userspace's
ability to request clean-slate, destructive conversions when needed.
Additionally, software zeroing ensures deterministic behavior across
pKVM, TDX, and SNP. The guest is guaranteed a clean page, isolating
the KVM uAPI from micro-architectural data destruction nuances.

Cheers,
/fuad
