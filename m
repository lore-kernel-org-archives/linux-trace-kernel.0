Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480116ABC3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715338999; cv=none; b=EOOcjdid7Kjc3yL6SMORAWkvc17Br8eQCJBqVeRZspkt3QIDVnj+hXhSd5jBPuGr59ShpcEp94ox7q7IkMTjuyjI3VIFZ45Q9b+d1bYEM922lsP1wjrfuS6nCu6xskw/eLkgzMrAzl+34slPsTnc0hfaN6kSbkjnvxrzNwj1EHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715338999; c=relaxed/simple;
	bh=wbz6QLqwAzQ7aZSh96uDYPLlmW+YQ8YBErjkKgtAZf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKy+M29/44e8RSszPda/+GdXMN47M1PPMOkUGxmX86OHjBJ7u2b3jSFBHJw/lX4T11bEz04r3psL1BjyRuV/bL/obSAMNx/OrDtE3eBk6qNLy98TvGJVOIZp2Br9Ikt+LZOgpZN9rHS7y38yFPDr1u6eSdnXWU7z3YCg11CaSeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OnFXK3LN; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OnFXK3LN"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41ffad2426eso3768505e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 04:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715338996; x=1715943796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rZVnCon/go9B9dTERYLh3cVfCiejO45V80tw8yzRpnU=;
        b=OnFXK3LNd3qIBd4IHPUDyCHe7YFH8K4f1wmX3wkfI5To+NukoQKy7J43XR2X4jTIA/
         R44N0+B6EN9iawhfyJXrxH0M5TfKQVQ0lR6ZCeDncrpz/93AbKf/DpcnDhDBCP6oozNp
         pVXXimf2ccp2aDFpByqRAkDMspqkFcVgBxby2q66VSg0NeNkAe+O0jMFeudn0QAsIpLA
         1QAOT/4McQGJQbYJk615cUv1OXdv26EiH/dSCp079NMLjWjVQEQjJaxxqmxihVhd+iLP
         lacVvEwSNjw/zEfn8ukiQXA7qJqZD5/1WuZ7GQhsd+w0kLooGdbhuW1Vkca7FyU9/rJT
         Djxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715338996; x=1715943796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZVnCon/go9B9dTERYLh3cVfCiejO45V80tw8yzRpnU=;
        b=fvmQl7ckCz/Msrd0dLCVUI/qxBibau+Yv2KPmfC7V0Zvw8+Krvvp6Jnaie2k+fbW14
         tm0t21UdtWtyFlOKDKmWxjIhIGrfX8AoRqEDj98j+lkgyvPjPW60uhwiwHhClnKxq3s8
         rNDeldrb/2sqo/PsXVbMJYrr/6JNJBakjixmiltZqU680ha8laE5zy0gxD733al1agKm
         3t4SKOoXrlfsev+wOLRqSmR8xBg4ZxT36eH59rh3yVkZTFQSJD5QTS4aSHbEMHFtOMwN
         6CijZjU2SwkAEnN7XseyJ6KWh6FgbG+QR5pbIyv8Wz3INskerOB8I8H0c1k8XGIe7cGW
         hQrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLVtPFuk9ql9Y8P28tRhVbT77izzEr26SayO6MWDVsxiyXPnG5Fu2LBLfUcEJ6RMJjikX2pl10aYRkzEu2oDrdP2UNHZT7IUBhI+QnvrhC6DSK
X-Gm-Message-State: AOJu0Yy+KVQKnVnYLJK0a3ow0Qmi1Q+0y3CoC4UXz+Paf2sHl5TgtmvK
	aijgpv/2YfujoFrnaPn0BRJl//Y9TX3RNIw7E7IeIVa1PMrTigfdW2lBiIS5aw==
X-Google-Smtp-Source: AGHT+IGuWY6L0MSRVOn0uzCJoaOvNXNJY2lGiyGY+cCoQhHxynAUP/AA2bNpVJyYrxN7Tpo1w5Qlhg==
X-Received: by 2002:a1c:7910:0:b0:41b:bb90:4af with SMTP id 5b1f17b1804b1-41feaa44138mr22551875e9.20.1715338996268;
        Fri, 10 May 2024 04:03:16 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fc6sm59614295e9.4.2024.05.10.04.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:03:16 -0700 (PDT)
Date: Fri, 10 May 2024 12:03:12 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	rdunlap@infradead.org, rppt@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v22 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <Zj3-8GHR_EiWY7lB@google.com>
References: <20240430111354.637356-1-vdonnefort@google.com>
 <20240430111354.637356-3-vdonnefort@google.com>
 <20240507223402.206d6ddc@rorschach.local.home>
 <cc719813-ba73-461f-8b45-4728f926c151@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc719813-ba73-461f-8b45-4728f926c151@redhat.com>

[...]

> > > +
> > > +	while (s < nr_subbufs && p < nr_pages) {
> > > +		struct page *page = virt_to_page(cpu_buffer->subbuf_ids[s]);
> > > +		int off = 0;
> > > +
> > > +		for (; off < (1 << (subbuf_order)); off++, page++) {
> > > +			if (p >= nr_pages)
> > > +				break;
> > > +
> > > +			pages[p++] = page;
> > > +		}
> > > +		s++;
> > > +	}
> > 
> > The above can be made to:
> > 
> > 	while (p < nr_pages) {
> > 		struct page *page;
> > 		int off = 0;
> > 
> > 		if (WARN_ON_ONCE(s >= nr_subbufs))
> > 			break;
> 
> I'm not particularly happy about us calling vm_insert_pages with NULL
> pointers stored in pages.
> 
> Should we instead do
> 
> if (WARN_ON_ONCE(s >= nr_subbufs)) {
> 	err = -EINVAL;
> 	goto out;
> }
> 
> ?

I could also nr_pages = p in the event of s >= nr_subbufs... but that
really that shouldn't happen so let's return an error.

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
