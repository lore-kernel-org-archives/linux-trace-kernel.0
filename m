Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2C242D6E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Apr 2025 16:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944600; cv=none; b=AC81fQFkoJqdmRwjHTAMt43/4I7nLOPHvN68w0KIk7Caa0wro+yszTKktU0QTiowbIQwIJs54Jh9G9ZeRNCXT6VwpFtyL1XaXpimvbpkUeo4O+VQMcSIrt69Vgx6Ovlp4x6ftjlKI7jYxD4L7HeNcahYSs4dLDiaocGSiyimldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944600; c=relaxed/simple;
	bh=xRPQTzVNw6kR4/8JZFHsXi/5pTBjN58UhIePapCj/+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NoeL9PEVJXrCz5aE4s1DtA2FfLvRs4dOVamnHEQ0LaaJmwno7ItJaXSF0NJM4xYSiAM8PnXd+DgKCD8ibBjSAJAPns1iQTxo9EQ0+OyulsXAtTxZEvJVF8ftzuFKDtc7ElXlCc0MKKmVDz39EEzyJbwlziDBNgJyHGFwoOOA6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Stywinjc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Stywinjc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745944597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=waEdyNuipqRc2FvA2naLTCSIIiKXgQ9HjpRrzr7KHVs=;
	b=Stywinjc33tKLUZAwNHyd7/dFRyzLSw6NZqYVzibb76DGnR6CEvJH1TSPhIkFo/37BMiSK
	1eHqdacXK5o0k3BFRzhS6eSqgVpDaRs1gCpKDCYySQxzUyw8HwgJiYEvihdwMfmWD+L5Zq
	WOJopZf6DBN87GnXny+8fIT9hUMSdow=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515--p8NIFJlM6CZnZW_UhVLsw-1; Tue, 29 Apr 2025 12:36:36 -0400
X-MC-Unique: -p8NIFJlM6CZnZW_UhVLsw-1
X-Mimecast-MFC-AGG-ID: -p8NIFJlM6CZnZW_UhVLsw_1745944595
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e90b13f5c3so124324526d6.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Apr 2025 09:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944595; x=1746549395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waEdyNuipqRc2FvA2naLTCSIIiKXgQ9HjpRrzr7KHVs=;
        b=M6sZ1uEj6b7Z5LlkFYU4hJQlA6YGIlGkKhgFrHfxfV8b+zAdUYnipgNZE0YhhfzS88
         LfTX6qRW7dQWjY97oXzmeERnC4elviyvPWJPpNot7+IgiAIoXw/KQCB9+zg8HxMi4LQ+
         8d2hy9Q8chToVHRmwHoChTdCXSps3CLwYuABG7LjbqdVY6pmPHeYaUP2AWQwsAKXO2Ll
         uqBbXsqmfhNh8JVGvcSRzGi4kDh46ma7/DgqLjZhtpo7Xpb+K01eqoTFNdqaP4br5lHc
         LBC4sVCWTsu2FPpTmRu5RqnlWhjYua1O7OzZYOZeN7GkO/tQqStRre8maqu3fQwjvGux
         0Lzw==
X-Forwarded-Encrypted: i=1; AJvYcCXPJ5qsU1DGgWELt4zO/XMw6RyxfOGLc1N1EHcJYzxyLYQ9aYRUllEUkVRGrKNlhqsv2Q375Ephe28anvd/y8swq4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwavAIFzvCyxvIQknckX1rhNs8hw8WhiU7teMb77K+m8ySd7nvR
	HSEMD2QJVLdib7uhUhz57/0c3D0S2wZMYA2HIV0pgtXHKef5BMjlWgIFLP8/np9gocQnA6KT98/
	/JNekvfeCe4+3YOACgSxues5lBRlT2R/DDExE59vPSfofEz4y6nNN6mt1q7YWqzEobRbxhQ==
X-Gm-Gg: ASbGncuHoJfN5N4ZLJ/wUvuIzIqrFAvHEE7vFXJgh48gPlhN2Wpuldci2xTXd0WxQlt
	uGYfofyb4NoxUIVSIcNhqv+ulcsGddbBRc+aIryRHVzuFLWHry9xweogfTfEMfffQ2QRWlAdzVG
	REdHk8KMi4E+zk7hPpmdPI2D3ySKVqM5BiYQsT7nrF2A1BFBF6//Y+kK30rCmPJVVjlgEE9GvtR
	TbnUUY7tAOqgeatwj6AYui75Eb4X2ExOiMs4wrc8M7NNY3XC3TM9QzWxuaM8b0R/aqT3lV0MA9R
	DTQ=
X-Received: by 2002:a05:6214:1c42:b0:6e8:feae:9291 with SMTP id 6a1803df08f44-6f4fcee30d1mr719156d6.24.1745944595663;
        Tue, 29 Apr 2025 09:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrl8H4/5jtnrguKExXXuFCOERrcXvTboYVKeLXf20R7G+3egGDvxPBeabBwEPjBOiCsfK/vg==
X-Received: by 2002:a05:6214:1c42:b0:6e8:feae:9291 with SMTP id 6a1803df08f44-6f4fcee30d1mr718716d6.24.1745944595247;
        Tue, 29 Apr 2025 09:36:35 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0934346sm73501926d6.33.2025.04.29.09.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:36:34 -0700 (PDT)
Date: Tue, 29 Apr 2025 12:36:31 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>
Subject: Re: [PATCH v1 02/11] mm: convert track_pfn_insert() to
 pfnmap_sanitize_pgprot()
Message-ID: <aBEAD02B5CIzonwU@x1.local>
References: <20250425081715.1341199-1-david@redhat.com>
 <20250425081715.1341199-3-david@redhat.com>
 <aAvjJOmvm5GsZ-JN@x1.local>
 <78f88303-6b00-42cf-8977-bf7541fa45a9@redhat.com>
 <aAwh6n058Hh490io@x1.local>
 <75998f7c-93d2-4b98-bb53-8d858b2c108e@redhat.com>
 <aA-q_PrThAw5v1PF@x1.local>
 <57f9480c-2f8c-4be8-864c-406fec917eb1@redhat.com>
 <aBDXr-Qp4z0tS50P@x1.local>
 <4a57e772-51f5-4341-a249-dd1b8fcf23b0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4a57e772-51f5-4341-a249-dd1b8fcf23b0@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HcnsWCvPR3XEilSheYyI23rHY4O21iBbdFUEFxVSzAU_1745944595
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Apr 29, 2025 at 06:25:06PM +0200, David Hildenbrand wrote:
> I do wonder why we even have to lookup the memtype again if the caller
> apparently reserved it (which implied checking it). All a bit weird.

Maybe it's because the memtype info isn't always visible to the upper
layers, e.g. default pci_iomap() for MMIOs doesn't need to specify anything
on cache mode.  There's some pci_iomap_wc() variance, but still looks like
only the internal has full control..

-- 
Peter Xu

