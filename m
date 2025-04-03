Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FC219CC39
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Apr 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743699133; cv=none; b=QM3sbeyme9Cm16F9OcAec3Sh1RDpyk3Pa8b8BfNWzY8ZK6nGYfRnd3kH2tQo9+prG0DMjmOVhbFIYZK5LmQQRPUF5KiWCt/EAAL73qGiqRZAeA5xqlRoudf24Z0TcBvgB+yG5d81eRJ25mOE6unA2aU8U1w/RsFyfxIAEqZ+ocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743699133; c=relaxed/simple;
	bh=c4k/wLTjjWRN0G3MQ4/ueWmzFfj6tAoe+LhodSB0qc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMd2Os5VA2Zzy+kBYvnhAvroomESKaVl1ngpvNeRXErsBZFxLcx1wz4XQg04ORo21/2eg00QtZ8jJan3k3R+Xrmu2Y5xD+sDslHSvIEOLJyWQg82c5Z6XHhjveTu0VIUENhBkB0dQJNcujIL1LoImA1C0uFiVJEsNfq8H/ojPnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ihr25YJo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ihr25YJo"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso1990927a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Apr 2025 09:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743699129; x=1744303929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zxz3ZOpXSZ7yPtvl/GON9cIiqoopL7kPorpXa/Hocqg=;
        b=Ihr25YJoxXhP27MSWtEzuoRRpRAJImXjRubbE486U5CPdvy3Y8kJxntEFOluZs2dre
         tsLyVlz6rQzfxez40bpsDBin1O1oedxQ0Kr+elZGx35TZCXUDp2O1Jyyr5ElUHqcxDUt
         4DgjnJxMU7B61E7NyTx69DOA8SodQSaEza7Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743699129; x=1744303929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxz3ZOpXSZ7yPtvl/GON9cIiqoopL7kPorpXa/Hocqg=;
        b=pPh/8FWC7s7GEcZHE3rhNq3q39qKemD6oa/gKHL8abs+NqUxC6KH9LQxnoPQjwfQzM
         N0WpOBOypkGn649eIeVJ/GH6rjZ/rKRCRUKy2h5tlGga9YVFYPlnIcke+R0D13WknjMT
         A030p3L9qkohYM+fegcH0wlsJj4/BOcwz309PUdw7oTdLEbGWe3w3I0wFJYhnpLNMp6G
         nMGvovgFiMHPLexou6z3opOQrIEKTb8jOMpG8uda7b4VPT0OJdc1pKMSxrH86qBa/ksM
         KQre8cv2Fc2MJPghQMAEj04IAxZYJ7/8ZWzxdFIsr/suwpU3BwJwmWtnYbWeaDdetGLp
         srfg==
X-Forwarded-Encrypted: i=1; AJvYcCWxblignP1nX7xbdM6oGXUcR3u4lxpBvOJ2URGm9AKLoIQ0/dn6YD2D9hib/c9XfaoVcSgbgF1bGbnjRO3Eg9BxpYM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww5FWtsvnwVNa7lfjx5NGKS4JoKe61hiaGNlj4s3EpKRxJAeYV
	6XTxrIfUJNXXy5H/YNWWXTym0riZdjSgdUqjxizoTXGBFvwbUOw9O8kkCQnHxfUpHPhs7MiL8v2
	qBa8=
X-Gm-Gg: ASbGncszGDuWWjjJQjTvaxwuvp/R+bSpQ2GXEaGynodCUXH0N3v3LqmZRGTR8UfbGrs
	RJtV3oe8VHwRetsloCpVRulXtdrEkfbxouEp+lP/OkYIfkqQIxshTldO9HUfKlMH7O3M1MELpol
	6MEbXWsrUU+qvd9L4QFvbiTg+APSeqjRUIJoCnFrgC00E2/iUh9ynFEG6IxNP/gbWYV5gifDFSq
	ED72VIV7wYOxG7/zgVfUuzIMeyO7DKdw3Wtrm7Wo1CZ6S9Z7+WZO+VLAeYVl+kOlPrd+4o9z5pu
	67o1CF816N+O/wegXMYhFBvnQxfu6o55K7iC4xHV02GrQ1+QQZa1SJBhPD0NN7ebV4lrS89fijH
	DB541jTSyL5FW+4FpKTY=
X-Google-Smtp-Source: AGHT+IF/+o/Cj/S9aBQ2FXpCNPYaIw/rDuNKkSZi8DHKp422uPA7fOrAh722C5HAET6178+UTyK4Ww==
X-Received: by 2002:a05:6402:42c5:b0:5ed:bab5:3093 with SMTP id 4fb4d7f45d1cf-5f0842069d6mr3813937a12.16.1743699129373;
        Thu, 03 Apr 2025 09:52:09 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f08760f0a0sm1186921a12.0.2025.04.03.09.52.08
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 09:52:08 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac2aeada833so221310666b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 03 Apr 2025 09:52:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4LC1dARUrwNm0igkvZvnXzE41gwP2zRO9HQv9WE3vzmft2qSmMy4KvVHqERGjMzPusxOXOwPcL9+odUSNOVanJQ0=@vger.kernel.org
X-Received: by 2002:a17:907:970c:b0:ac7:3028:6d67 with SMTP id
 a640c23a62f3a-ac7d2e9734cmr3856966b.16.1743699127992; Thu, 03 Apr 2025
 09:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <202504030941.E0AA2E023@keescook>
In-Reply-To: <202504030941.E0AA2E023@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Apr 2025 09:51:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwSx8Bm6c=UEe0Xh6MvkZ9aAYhYBTwUxYk3Fu6GehHVg@mail.gmail.com>
X-Gm-Features: ATxdqUGzamms3HBwS2oeFKY1M4I1ihINB3lWR76jBDO6-iwI1TuKjoGv0rxX3qw
Message-ID: <CAHk-=wgwSx8Bm6c=UEe0Xh6MvkZ9aAYhYBTwUxYk3Fu6GehHVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Kees Cook <kees@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 09:45, Kees Cook <kees@kernel.org> wrote:
>
> pstore tries to work with either real RAM or with iomem things. What
> is there now Currently Works Fine, but should this be using
> vmap_page_range()?

Yes, I don't see the point of using vmap() on something that is
contiguous but is made to look like a collection of random pfns.

IOW, that whole 'pages[]' array (and the kmalloc/kfree) seems pointless.

I *suspect* the history is simply that 'vmap()' predates 'vmap_page_range()'.

But maybe I'm missing something, and there is some limitation to
vmap_page_range() that I'm not seeing.

             Linus
