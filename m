Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8195303C97;
	Fri,  7 Aug 2026 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113930; cv=none; b=SLARKyhFsO/OTAu/CPQP120Ul7z8GtZYJvrNO76Nk8VdzguwHk/we7dnedaoRzxZnemaURh5ATHrf++BhMjO3AC+UG6Jf/eueD6mvXDt4ULy+lGW0EsbA9IXs9i9pPpQCnZsTBxVkKaeR9eBi8QaajJLpskT5cJAtGqHAfQnaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113930; c=relaxed/simple;
	bh=feuSzPO6Tth4ClVKIYCN8sNhQi5HH2bx1QWb/2JofCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgQcbSrx+yI2XWMy21t9G54pgmtFQLwVTFuiKWBxgL7S9MdHGhCCnVFPHQRY+lLZh554spX6/IzQS86GSUWToqJBXvK4+2V62XcF/QJm6xQ7CfmkbwPGQ4Q1k88d+Ql9qlO+zTKsk8Yboevo+mFalMS3GQp+hbaixM7kQ0jI4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 297A3803D3;
	Fri,  7 Aug 2026 14:45:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 49E4B20027;
	Fri,  7 Aug 2026 14:45:24 +0000 (UTC)
Date: Fri, 7 Aug 2026 10:45:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-ID: <20260807104526.38430aa2@gandalf.local.home>
In-Reply-To: <anWosNi-U8lVqBZP@google.com>
References: <20260806211306.3704194-1-vdonnefort@google.com>
	<20260806211306.3704194-2-vdonnefort@google.com>
	<20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
	<anWT4heM5Z--A1Mo@google.com>
	<anWosNi-U8lVqBZP@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ekcyfxwtzyaoymphc4yns4arc8ktwgf3
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 49E4B20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18beZWVU9dq8M0FX6Ljrnmo+nryfdfrDGY=
X-HE-Tag: 1786113924-687181
X-HE-Meta: U2FsdGVkX1/+zf1lL27S4Ts/T09xsBUYRuTDtaaYMMAukRt7YhdQzrWHINesWjWl+7x06y9KKskrNFYfDTIczNltpiC7B1rk0ehofB1h1QVfvDIhahMB5QkRdNAXQefshAOUMIkGpUTsQthKY7O2R2FOVKqgqKliH+nLfLZJ7tG5gbqqZC2yr0grzRFnc4ItjgCs6bnWnGSdrn1ac5XFT/2yTV96zF1+4JDFF2aHe3TjkpjWcdBIBZFn6LTOi45k5zcO4LYC7cQGUx8rdEO8OyoHRvm74jfZjJ5ky3mXVeRFGU1ztdcR6f9oTFISyJ4Jx/iEn4UKx+tgB//DJGFPiPbuua4JB18A

On Fri, 7 Aug 2026 10:43:12 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> On Fri, Aug 07, 2026 at 09:14:26AM +0100, Vincent Donnefort wrote:
> > On Fri, Aug 07, 2026 at 11:18:08AM +0900, Masami Hiramatsu wrote:  
> > > On Thu,  6 Aug 2026 22:13:01 +0100
> > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > >   
> > > > Dynamically resizing a persistent ring buffer is not possible. Disable
> > > > the feature.  
> > > 
> > > Is it true? Of course there is meaningless to resize the persistent
> > > ring buffer (because it makes the buffer none-persistent), we are currently
> > > allows user to resize it (like for resizing unused persistent ring buffer)  
> > 
> > __rb_allocate_pages() in ring_buffer_resize() would call for a persistent buffer
> > rb_range_buffer(), which IIUC, is just reusing the same ring buffer pages as the
> > one already in the persistent buffer.  
> 
> I have just tried and if reducing the size works, increasing fails in both
> rb_set_head_page() and rb_insert_pages() with a warning, which I believe is
> expected.
> 
> We could improve that, but it feels like it is a lot of work for a meaningless
> feature which we should just disable?

Resizing a persistent ring buffer to a smaller size may be allowed, but I
see no point in increasing the size. Making it smaller should allow us to
give back a portion of the persistent ring buffer for general usage.

-- Steve
