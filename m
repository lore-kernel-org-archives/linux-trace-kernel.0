Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B392FFDFA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769538705; cv=none; b=HCcl9qQexgV0i4QtWi6YKdf2mgRvwk+XoyTilLi2/xdk/PEgeWuhmxTpI6wZsQb8n5yfFJotQLL7eecSkfazylaZV4QaAcLypZUXCjE3cJNDRM6pE+mIxAKf/LgFlNzNmIWPvrz2G8hC1U3Nuq6q5AGlybORU1q0xstzyNeADdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769538705; c=relaxed/simple;
	bh=h26afcKOHIVNnzkGt0ZdZvKmdm5p5/NPbHS+3QBbrPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R25Dkwewt0pY+9Uonc5TOplydapK1Vc7ptHSzaME2n5eQ55rU3dl+uBma0byGb/ByVrzYP4pTs6lHsJYivm8X//si/0qzVWsPr+o9nRGIvLSDorwnZyEaKjH9eK2SM3FBI2Zaf2R7ubMdaPa0tUcq7KtYEEUkQdjEj5MEarjIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dxRAU8Kh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dxRAU8Kh"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a76b39587aso8115ad.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Jan 2026 10:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769538702; x=1770143502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M7H/8xfB5IYsah8RhOLV2MePrkEzYaBFh1rOK2YldAs=;
        b=dxRAU8KhslJocLzcAVGwR+vqSEYqpg8Ysyi0osRbrHcf/xSeWJNyXtHVgJRWpREJL6
         hOlp4NHzoH1DMXNUcLAY0TKSt+1/Bp/4idayQSHWNkiE8QgPpPi0H8PzKmmMxbbRucNE
         lMvZjSCFqb/Uz2NRbq9hHYpp+b+MNo3056c9PmXEggtCBtcCKFDCRPIMRMYPwNJ6bHvI
         xdVRx83fvZUduDu4jrGHPCUYZRw+IYgAokzkVQWeknFO7b3YJxEfMIUh3glL0s+jS3yf
         liDKSUY2ilfAhrpzQHS/ukk1RGJdV3TMynt16xvmxgpGYy99/xKmdCth+r7jwJOq7KJP
         2sFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769538702; x=1770143502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M7H/8xfB5IYsah8RhOLV2MePrkEzYaBFh1rOK2YldAs=;
        b=dnC0nSrZ4IzsaK02aTtN7HrSspg9AEE18bCBGi2Dt6qPQb4ShWY0iD5Iply/gEt2TP
         ZNrXI2yypyAu+MNwS+aFRDyyWh1ZuNubhpTtsc7VTy+vitz5jiSyCiajmdIbjoR6UwRx
         svhXhR+LmYM0QC2ObtL+OVcNkJX8SO2KMNXWKRjxyuIgZ+/9nXNeKURfg54nMkGmHjMW
         +QsCi7WpCwv5GgFlTou/X6vlludRYL0KTEorH1I+0KI5V0OIwXht2GO4tSrBwDEnrw1B
         6JPWzGQI2DDMncLuA90htH8/PNTx74WR6qiZ0ImL2FPBiVx9Z2oDD7FAHIinqI8kRFZh
         Ky1g==
X-Forwarded-Encrypted: i=1; AJvYcCWD/gwx5HHw0CO9BxjRB5PmiGGF3YdvT+1HOvpQ+8TWb6oMM7wQPte4vl3Nrl/6W9nCspBBWUIjgtuyHcDpESEbwF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AVl7/mfquFjOiOkUUBianINFHHT6RW0LaZPfNgTObh8ZfU/8
	ZAl2qfHYTzW4+5vAL8hOMrKiqFz1Eo4W0ofrAz+ITcaArl25fuyK4N3x0/p+vT1mkA==
X-Gm-Gg: AZuq6aIhZFuX7MWelx0iAAIYxtCTecl6ivgmvc9/dFNBX4kMxGNw2a5tS80+gO/2ad2
	rCZqS+Zxd0MBd0OSeeazGGOoLBeDJt09uvp/9FhMGfZqoDU3gOgTYC9xRARzaiIYf5Ir8WUXEqJ
	WouNjdJxIQuYk7XN3dHO/0gDxR6wvxIt2LKmAotsneW6de6ZcniMu+jdpTbVcH3O3XvBwNhoSdO
	WhCMcUuZGVrRJ6mWDbeItjzIXqJHzwwbWL9KPAlEtk6aODOZkDcRNhM10rKARUhmER2FhgXrwbE
	IiZHE9lNEOMvdw6Qs3gs+B3x3ueAWFBsS7eJmn1GmkfYG/sn4gw1l4H8ccsNTZ5K9lEnYPUMcTp
	ouc4pT425iBOxkHi1Vo9lYO/b3I2V2e3X5hRahRlxbW0hSZEPOnq0/BBbuYlZGDudTifgjzA55i
	2AuMG6N3oaS5GWpruWZRwyFNRLn4Wwz/sSSeyYyElw8HkmDrjMuA==
X-Received: by 2002:a17:902:d583:b0:2a7:6fd3:c11e with SMTP id d9443c01a7336-2a870b4f72fmr2828205ad.18.1769538701664;
        Tue, 27 Jan 2026 10:31:41 -0800 (PST)
Received: from google.com (28.117.125.34.bc.googleusercontent.com. [34.125.117.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3b1esm605245ad.63.2026.01.27.10.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:31:41 -0800 (PST)
Date: Tue, 27 Jan 2026 18:31:36 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	rust-for-linux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust_binder: add binder_transaction tracepoint
Message-ID: <aXkEiC1sGOGfDuzI@google.com>
References: <20251203-binder-trace1-v1-0-22d3ffddb44e@google.com>
 <20251203-binder-trace1-v1-2-22d3ffddb44e@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203-binder-trace1-v1-2-22d3ffddb44e@google.com>

On Wed, Dec 03, 2025 at 02:48:09PM +0000, Alice Ryhl wrote:
> This patch adds the binder_transaction tracepoint to Rust Binder. This
> was chosen as the next tracepoint to add as it is the most complex
> tracepoint. (And it's also an important tracepoint known to perfetto.)
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

This approach seems to work well considering the limitations. I wonder
though if it would be more practical to simply pass the individual
primitive values used by TP_prinkt() from the start? I suppose the
downside would be the extra overhead with the tracepoints disabled.
However, this might be neglectable and the solution much simpler?

> +static inline rust_binder_node rust_binder_transaction_target_node(rust_binder_transaction t)
> +{
> +	void *p = *(void **) (t + RUST_BINDER_LAYOUT.t.target_node);
> +
> +	if (p)
> +		p = p + RUST_BINDER_LAYOUT.n.arc_offset;
> +	return NULL;

It looks like this should have 'return p' right? Sorry for the late
review this has been picked up so we might need a fixes for this.

--
Carlos Llamas
