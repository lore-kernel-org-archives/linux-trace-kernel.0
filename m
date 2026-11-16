Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794868061;
	b=Zm3ZptUQnEei+KhDw2u2V3ngtUwH5Afu74kpvHDESnWNkn88g6970JfqpCbBxDEvml+Q
	 iSTOCqw2EIkJgNJKOEtJzt/4D5H1NdfwoO+yZUHoVYDHjmnGpaB8ZNQf329cl00BK4fDx
	 g7vIHXJ/HstlK3CJlJndh3eFvKA2fpBQxuatFAlGw8vHIi+ljzMRm/0xn3ZAh4yizJZTi
	 RZxPuwJQbxwKJXztJRAqyj/xmhTr+C82nGElGeWR1dnt0Qj83/dP/75AWzUtdVTu2hwOu
	 vI6Uu+RLZGvKSS8QsL4ns59MvVBrBUSJp6O0qVfO3pTbYxcvvzduGKb+HQ/PQzazcJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868061;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=MvAoeegayQ3Oq0+PxbYV5Lu2mIQx86XP+/DH4rlp/jI=;
	b=VOtM2kI05kJTp484VesYpi4wg5yEuepvtBMXAhzVsqGMZ79XLJDLSkWDsdz0RbEDnb++
	 U7jUKgtUlZlRRNimnPr4VuRM+VOVaOa93LaL/v0K6eZk0kzi05lYymCGx+HtGA6e8d1J6
	 3xcPvaQvChmJRRjr8enmOB3l8T2UKmj7cVpK/CiNu8sra0qxjr6heh2A+vIHqM2lbAR5y
	 JyKXuTLX7KwL3zCc4ZoEMfc/0pG/C2dyz8lAEgU1dwLjpyUq6Wl+OtfIwE/BCMc2kcloV
	 5yq6Ga88tNMuNG1r1Yi5VYWU7zB6y+HDGAa0/Tzbn/McYti/HaxKp07qTUS1G1L14GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Rzj+40u3;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54329606A339;
	Mon, 16 Nov 2026 22:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54329606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Rzj+40u3
Received: from CPC-beaub-VBQ1L.localdomain (unknown [70.37.26.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B6B220B716F;
	Mon, 16 Nov 2026 14:27:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B6B220B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794868054;
	bh=MvAoeegayQ3Oq0+PxbYV5Lu2mIQx86XP+/DH4rlp/jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rzj+40u3iIwJicaJCxrE2Y3yaPR0U0Icxz+QxM5dv9MCJiVDTNaVDBDK4lIyzc3Jv
	 YIaadD/xKsrlygtVS8hzbylCtayBpEsn1ROB5Tdo9gfZL7AxTZsdsBAv/15RZwIWet
	 97yhIjZ6S7gqm6ecyIsraga5ZnKMFS/PCixmaBgY=
Date: Mon, 16 Nov 2026 22:27:32 +0000
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jeff Barnes <jeffbarnes@linux.microsoft.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] tracing/user_events: Share state with existing
 threads
Message-ID: <20261116222732.GA131-beaub@linux.microsoft.com>
References: <20261019103957.69759ee3@gandalf.local.home>
 <40C83F97-D53F-4050-9CE4-19449912FB20@getmailspring.com>
 <20261112042506.0fca0524@fedora>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112042506.0fca0524@fedora>

On Thu, Nov 12, 2026 at 04:25:06AM -0500, Steven Rostedt wrote:
> On Tue, 10 Nov 2026 17:50:03 -0500
> Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:
> 
> > Hi Steve, Beau,
> > 
> > Gentle ping on this v2 series. I don't have any outstanding changes to
> > make at this point.
> > Just to clarify, this is a separate patch from the Fail fork one.
> > Please let me know if anything further is needed from my side. 
> > 
> 
> Hi Jeff,
> 
> I'm currently traveling back home and will be taking the rest of the
> week off. My backlog is a bit behind and I'm trying to get through
> them. I do have a 4 hour layover, and I expect to work on triaging
> patches. Hopefully I can get to yours, otherwise, it may have to wait
> until next week.
> 

I had work related delays, sorry about that.

For the series:
Reviewed-by: Beau Belgrave <beaub@linux.microsoft.com>

Thanks,
-Beau

> -- Steve
