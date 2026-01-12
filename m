Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7E3364049;
	Mon, 12 Jan 2026 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235330; cv=none; b=dQ1jff9X2oC7UN7KyLteowzu7QhMBqhhWigdrl7L+27C0vihUucVCkAUnPoFjOohwkPK7jYkwWDN80dGHrnTNnXIoeN8qLss9LpyYXm7I0chWxrY/2ajoivvFHz+g85O2ugecZMcFpq4qbwsxNRbCBpMCxKEaG7x7qdli8SVXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235330; c=relaxed/simple;
	bh=WHR5uz90wuD/NDZp3iKY5GXi+HtBpKpO71w+PxXr3fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQASg+DbFQtNlaXj0cneagOiNzvJUyRrRO/b6+uh7STFF1MYImB+h9umCj5pbWUtnDTD08rTYrQkvWvJCcwwEc3Ibr/IvpiwRTQmXXev+0tXYZvV70/AQlN4GOSXlOse/8GfFsCnJHQjX83Gwm/YMZUInA3isDFDKosCCK6+G3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B6EA81A06D1;
	Mon, 12 Jan 2026 16:28:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 73C4820026;
	Mon, 12 Jan 2026 16:28:39 +0000 (UTC)
Date: Mon, 12 Jan 2026 11:28:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Fushuai Wang <fushuai.wang@linux.dev>,
 akpm@linux-foundation.org, brauner@kernel.org, cyphar@cyphar.com,
 dave.hansen@linux.intel.com, hpa@zytor.com, jack@suse.cz, kees@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 luto@kernel.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 mingo@redhat.com, peterz@infradead.org, tglx@kernel.org, vmalik@redhat.com,
 wangfushuai@baidu.com, x86@kernel.org, yury.norov@gmail.com
Subject: Re: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
Message-ID: <20260112112842.5d5171c3@gandalf.local.home>
In-Reply-To: <aWUWBfKhP8DvzhDl@google.com>
References: <CAH5fLgiPdBEN7mjgK64u19VGE_AWghTnCCHYuQQuwnTdvDaYkw@mail.gmail.com>
	<20260112122236.22214-1-fushuai.wang@linux.dev>
	<20260112132238.GDaWT1ntPxY8VD1hlH@fat_crate.local>
	<aWUWBfKhP8DvzhDl@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 487iipcmhkih8ocgpmjh6yhz66ppnjns
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 73C4820026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/e0x33X3/VDNyeCq8BfJe4/BZfFhn/grY=
X-HE-Tag: 1768235319-391434
X-HE-Meta: U2FsdGVkX183ImCTBz8zLISF1hD+r2mdCc3Z7mavCAl5X7xEmhYGhINsWBxn4k9EUf4B2KXTi5ShG5qhU2bkwGIxtTMJHQQxvSBX+b7qZrLeDFtBHegTi+3vdFihyCtwWzJJMUTS2V+XZJGNcgikWlV1MC5HvjB/aHHh6dWEZ5jHq+HgSiiEFQXnAofQoqyuPhMcw2MzXD9unpMVgxiSJzZesOzWG7+Wyy/T3wmjvAIYXXHGK4Wl8Go7/CFXTNx5hqQ1Tig0K1LsOAM0UBlS2CkFPqh8rt33e/WjcnPQ2MrQ+vNaqBRv68WnOk29uVwWxBPL6QD/OXNlXproxrKN27FalExXn1He

On Mon, 12 Jan 2026 15:40:53 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> I'm getting the impression that strncpy_from_user() is the real problem
> here. It should append a nul byte.
> 
> That would also be a lot less error-prone than the suggested new API.
> Requiring a length of N+1 is not the most immediately-obvious API.

Should we make a strscpy_from_user() API that acts the same as strscpy()
but from user space?

-- Steve
