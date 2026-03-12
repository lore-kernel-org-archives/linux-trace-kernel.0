Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC272BEFFD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359677; cv=none; b=JXBSL3hZPqJeHVBNFmi5TzeuKvkpEQ2rBWjjlUaUgU0DlF9O0PVOV+IwVnG59m/FmQL8IKhOIQZZ5/OOzmUd0LBhsZ6xb8HwuC++RZdVy7D7U5yc3upcT7uBh5W3cghy4U3/aPfSA+uCPw7fap2P5AQFcIJi/bc8epAg281xdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359677; c=relaxed/simple;
	bh=wOUC16WI4/reo5GvoZO5ESmt8rfD7PE3++Xf9novjKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DH3q/FgspwQ2W/fOr+/mKHx/31FIRIHN473pHewOzDYMWQloM7V1gT341iXLkRYSKAidPt7qOpPUSvj0/DnehPckt/ojxXnJnoa2l5Q5pApB6YEeWDOoeHXbU2syqqm68ZVKH8U4x2Mx+OpDuEFfsIJW3Ap2R6+jTPLFvwyWifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FS1W6xRy; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FS1W6xRy"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b976e181895so2865666b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773359674; x=1773964474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=FS1W6xRyPzTb+AekkNw1gVm9VnIa3TB4UJb9VxJNQJZfj/AWAA4CzIpAWVJFxL+5EV
         waFzjSeSv26gcfAk8NexfeYn3bYuMGjTUhDYuCMD+iUyEckh7Dj7vM/Eyuu9wBnCXXMh
         xZpH91Y0or7Z1WrzzcykCs2amIBAR1kALjGXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359674; x=1773964474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=VdcCTqQ8R9LMpnFTGm8LKaXldRwUmzuRFxiLh+kdHFR7bITEOaKGhqvkO4qELHrVuG
         oUVrdpUzIE5l2Ecc5Eweq9Wl2tVkRKd0ITzTTusqLb6zlP/jiVpU6V5rnD+NV+GFIEkk
         6dWOX7DOrMOuZF2qgfc6hGF6pf6llpB37v0/N1ER6dmn+Wf57JfcyZdXiQWwxwqiKr3m
         ceERS+b07iLXdT9rN0DcnbiLbwEjIfxIbMvXQ+64wgFwS/Wh+2eDL8pTKS9Z9B6Sfmbq
         AidldrH9fZWPKAuayopC2yweI8memMeAgRO1wUHY5fludKYDaS8790/WeHobxLXRtE2K
         fsXw==
X-Forwarded-Encrypted: i=1; AJvYcCUTqr62RgblL3q+LE72g1dq+bE03hTzKWb/PB9LvcVJlWP7GkCyy2ZAivbsg0Cz6RBxmHxVBFawDqjsoF92q4vjUvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMriF/x4erClN+lASHLHu2fGXObzgzQ/VgywRJg55M5rL8xFT8
	GlXqacOOu8micWQ0JDNyUpk9msZzIDgpm0gutKsdD1MOuIGYSIuhCmohcXErOuu8AmBovyJgphz
	CoC8azF4=
X-Gm-Gg: ATEYQzwoLGCiePFHgtLdleHAVzDepqfRqgCURZyQE3ODMABr0qGYukb6wBztNWgek9q
	pOm92grT95u0D+09vsrIBLizKIXvuAbpC9AjssIzp1HiD8+fAueQnirZiq4jf62G7+l4mIkLOOm
	BcxqSomXBtxW0BJ++9h8Ekue6Me7fidwDMMode0+4ukoBR/jyby5FzwqWMpwLVGlM580E6auKyz
	LCfsTdke4vmwO9VrcQf43rJr4Wm+3SNWtM4sRVKFNbIUEgm6y89oTwRMEPOGfwtQPuqeBWo6Z/s
	47vwXl95trR1lzEg+t46XewtX/4QMPRuyrkVqxU6we03sUZ9PATw1yymC0yHKxTLfzBcemWwjTL
	oXsd7DIAjjntZwJ8gS2zWwbO0TrcZzIeLmuN4xPjzhKQnVogaRYPlmlUoxPFY9ek8ehDu0iqEyG
	hS3MiIKrbc08cpzus7cBxMRaHd/9mopZFFPlRzO/DmKIdpm92nWyOIAbdXd5DU8bNO2a7dFUpO
X-Received: by 2002:a17:907:a42:b0:b97:17b7:d8eb with SMTP id a640c23a62f3a-b9765392026mr68146166b.38.1773359674355;
        Thu, 12 Mar 2026 16:54:34 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b976d0b5886sm2994166b.65.2026.03.12.16.54.34
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 16:54:34 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b96f02b4329so272658566b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 16:54:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSI57+F0LwlnHrDK8Nx+Pw5TdDqxpx+pdtOj2BRIJh+01MYj8rQzVb4JEz4er4ZuKZ4rFo3U15uVBoS/7ZyxLL10M=@vger.kernel.org
X-Received: by 2002:a17:907:c5c9:b0:b96:d802:8b41 with SMTP id
 a640c23a62f3a-b9764fd8722mr66207066b.15.1773359215961; Thu, 12 Mar 2026
 16:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312214330.3885211-1-neilb@ownmail.net>
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Mar 2026 16:46:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
X-Gm-Features: AaiRm503fTaccEgKNbxF9h_dDHM9fUsSr52XJuxzTwCI0G9L03uDq8g5di1zchk
Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Tyler Hicks <code@tyhicks.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 14:44, NeilBrown <neilb@ownmail.net> wrote:
>
> This patch set progresses my effort to improve concurrency of
> directory operations and specifically to allow concurrent updates
> in a given directory.

I only got about half the patches, but the ones I did get didn't raise
my hackles.

HOWEVER.

This is very much a "absolutely requires ACKs from Al" series. Al?

Also, because I only got about half the patches, and there's 53 of
them total, I'd really like to see a git branch for something like
this. It makes it easier to review for me, and I suspect it makes it
easier for some of the test robots too.

But again - this needs Al to look at it. Iirc he had some fundamental
concern with the last version - hopefully now fixed, but ...

                 Linus
