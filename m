Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523ED3812C8;
	Tue, 12 May 2026 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592855; cv=none; b=TTWugu5SNW9YwtnkxfYPZp4HyWd4FlhrO3lyGgwcyUphEGyuknw8w2T89/aEzBegp5B01MEkKO3MByRaz6kvrKys3uEEZFXIvOXWvPfqU12c/c13tjtvWTxQL6he6FsrEncL7diunBNbV51P+FvxertS9kBP2KaeFj//jHB1MkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592855; c=relaxed/simple;
	bh=n1r1R/3grt+L5tmK8Q8JI5N6N+PYMNzn5ZWqv6i29BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OElY6faQfi4kwK6kZ3kyXLY8Z7mQmj2ynGrc7sxthpahZo1i6Af6C6S7Y5ej2FfeNhyTuil/bmJlm/Hb/QFrc/ly545U7RA0xHBBkKvPXUM2+Q+jJ4HJ6D7FYekinF1V6f0rdl0lDfAYY7QrkaGKgtr6o2Wk26vBAYxptKyMWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DOX6gKst; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DOX6gKst"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7WkcVadBrY1XKpqeX0xMjVFVAlCVexI4mnyeEkffHUE=; b=DOX6gKstXwYkD/1QVtjEgDYhjg
	xMQ/0N8TErdX0WA4LFweELRgU+9lEIJbdD5IJkkFgbNULe7AGsD1U+vCIP+QXYJqeh8sZ0KuqZilG
	0xt82S9d0KoknAVHlrKCDRnHgiWf3I+qy08pIXKogB1L3P64bAtXSoQX33nPD0Y8+PXNcLGsS6s12
	2vlSK+O5cFSCjPFYUiKYQXaFMW05cG5TldGW3RPlF9DJbXe/UnxiijRdkKOHeR+q9xoJAsJ++awON
	OEc856Y6OErMCUcydm8uArBRUaxKx4FKJ4TSnSHzZ6STcEzROb12BnNonw4bnjMCpM/syN9MJLQ18
	E5i00zbQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMnF6-002PSz-1Y;
	Tue, 12 May 2026 13:33:48 +0000
Date: Tue, 12 May 2026 06:33:41 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Liam R. Howlett" <liam@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v6 2/4] mm/memory-failure: classify get_any_page()
 failures by reason
Message-ID: <agMpqhpgmezqnaA_@gmail.com>
References: <20260511-ecc_panic-v6-0-183012ba7d4b@debian.org>
 <20260511-ecc_panic-v6-2-183012ba7d4b@debian.org>
 <28b01c14-3d87-4cab-b695-5b9015578785@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b01c14-3d87-4cab-b695-5b9015578785@kernel.org>
X-Debian-User: leitao

On Tue, May 12, 2026 at 10:21:50AM +0200, David Hildenbrand (Arm) wrote:
> 
> >  		}
> >  		goto unlock_mutex;
> >  	} else if (res < 0) {
> > -		if (is_reserved)
> > +		/*
> > +		 * Promote a stable unhandlable kernel page diagnosed by
> > +		 * get_hwpoison_page() to MF_MSG_KERNEL alongside reserved
> > +		 * pages; transient lifecycle races stay as MF_MSG_GET_HWPOISON.
> > +		 */
> > +		if (is_reserved || gp_status == MF_GET_PAGE_UNHANDLABLE)
> >  			res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
> 
> 
> It's all a bit of a mess. get_hwpoison_page() should just indicate that a page
> is unhandable if it is PG_reserved?

Are you saying that we should identify if the page is PG_reserved in
get_hwpoison_page() instead of in memory_failure(), as done in the
previous patch ("mm/memory-failure: report MF_MSG_KERNEL for reserved
pages") ?

> Why can't we just return a special error code from  get_hwpoison_page()? We ahve
> plenty of errno values to chose from.

Something like:


diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 866c4428ac7ef..0a6d83575833e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -878,7 +878,7 @@ static const char *action_name[] = {
 };
 
 static const char * const action_page_types[] = {
-	[MF_MSG_KERNEL]			= "reserved kernel page",
+	[MF_MSG_KERNEL]			= "unrecoverable kernel page",
 	[MF_MSG_KERNEL_HIGH_ORDER]	= "high-order kernel page",
 	[MF_MSG_HUGE]			= "huge page",
 	[MF_MSG_FREE_HUGE]		= "free huge page",
@@ -1394,6 +1394,21 @@ static int get_any_page(struct page *p, unsigned long flags)
 	int ret = 0, pass = 0;
 	bool count_increased = false;

+	if (PageReserved(p)) {
+		ret = -ENOTRECOVERABLE;
+		goto out;
+	}
+
 	if (flags & MF_COUNT_INCREASED)
 		count_increased = true;
 
@@ -1422,7 +1437,7 @@ static int get_any_page(struct page *p, unsigned long flags)
 				shake_page(p);
 				goto try_again;
 			}
-			ret = -EIO;
+			ret = -ENOTRECOVERABLE;
 			goto out;
 		}
 	}
@@ -1441,10 +1456,10 @@ static int get_any_page(struct page *p, unsigned long flags)
 			goto try_again;
 		}
 		put_page(p);
-		ret = -EIO;
+		ret = -ENOTRECOVERABLE;
 	}
 out:
-	if (ret == -EIO)
+	if (ret == -EIO || ret == -ENOTRECOVERABLE)
 		pr_err("%#lx: unhandlable page.\n", page_to_pfn(p));
 
 	return ret;
@@ -2431,6 +2448,9 @@ int memory_failure(unsigned long pfn, int flags)
 			res = action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
 		}
 		goto unlock_mutex;
+	} else if (res == -ENOTRECOVERABLE) {
+		res = action_result(pfn, MF_MSG_KERNEL, MF_IGNORED);
+		goto unlock_mutex;
 	} else if (res < 0) {
 		res = action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
 		goto unlock_mutex;


If that is what you are suggestion, maybe we can create another
MF_MSG_RESERVED? and another return value for get_any_page() to track
the reserve pages ?

Thanks for the review and suggestions,
--breno
