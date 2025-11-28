Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD8224677F;
	Fri, 28 Nov 2025 01:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764294235; cv=none; b=i5o1wn8EhqyHZL3qYpZtFQi1TPQJggIewZ5U4WhSbbRRr/6lfyOJHHNV2AdRXsSXIFOcQweS8r0POoUbDE7QmloCLC/WyMD9FGoEEPFNC1+0oTff6BAPFHpIlCykwnZ6yePiwWW01oZnPJN5YtmWtQGgTq5xNgWIocRGHvbQSzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764294235; c=relaxed/simple;
	bh=hI2AlAGRUfEQIRTCU/M1S+9wunj43CfaYMiVZOlZkUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqK8GmSTIklUUHCoSC5F/7z/A0RP5FhKqBFHlI/5R98Mz88JQAcEM+JzwsdFuRF0+RRdKJrlNySIC75fW78WhtTCmnz0itrz+mm0Dvmd5pKih+hCstdsD9T+my1HMN86JJsRPXYxrb7pGgqFyXN7eUZULuZ907oknvkwbySjRsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 55DB2C01E5;
	Fri, 28 Nov 2025 01:43:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 4E06D32;
	Fri, 28 Nov 2025 01:43:43 +0000 (UTC)
Date: Thu, 27 Nov 2025 20:43:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Subject: Re: [PATCH] overflow: Introduce struct_offset() to get offset of
 member
Message-ID: <20251127204342.05fc985e@robin>
In-Reply-To: <202511262356.6FE5084CB0@keescook>
References: <20251126145249.05b1770a@gandalf.local.home>
	<202511262356.6FE5084CB0@keescook>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4E06D32
X-Stat-Signature: d5fyncnia538jeygpg1h165u1uim4gja
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19bIv8FFQxKxBe++i0U6EbDErefzNShTIA=
X-HE-Tag: 1764294223-76900
X-HE-Meta: U2FsdGVkX1/5Z3uo5XrRmomqDCOjWs9b2Z2TJexDDWQYqFqkR00OyxP0i0PMHtH5GSuNK4NAxBlIkmqNNs/xFLg4YJ0fyBYiqL2w54L0V+CUnpKWP+SZwApTg7MdfyT+ax8/ISdMoauKkHx+zsn3COZc5YNzt860t2gNLSQJUZiBC+BBop4LExD7Y5uOEZiMZmgQhhZQayBmp1fZ45oP432wGXSG+grbhouwzs5R9novn6wKLSXP/MVjfitUGsLVmqGEi49+SmU/8UKkR0msVh2H2O2w8x+DEMrgUxGFa38g9XBYVu2F+DVKrBzJszEwyfEtaDvnO+6mcKki2ILgTXMBad6N5Aju

On Wed, 26 Nov 2025 23:58:01 -0800
Kees Cook <kees@kernel.org> wrote:

> > +/**
> > + * struct_offset() - Calculate the offset of a member within a struct
> > + * @p: Pointer to the struct
> > + * @member: Name of the member to get the offset of
> > + *
> > + * Calculates the offset of a particular @member of the structure pointed
> > + * to by @p.
> > + *
> > + * Return: number of bytes to the location of @member.
> > + */
> > +#define struct_offset(p, member) (offsetof(typeof(*(p)), member))  
> 
> I wonder if the kerndoc for this and offsetof() should reference each
> other? "For a type instead of a pointer, use offsetof()" etc...

I know I pushed this to my for-next branch already, but it's the top
patch. Looking at my code, I actually have a lot of places that use the
offsetof() for a structure variable and not a pointer to a structure.

Thus, I wonder if it is better to have this as:

#define struct_offset(s, member) (offsetof(typeof(s), member))

And then for pointers we have:

	size = struct_offset(*entry, id) + cnt;

If you forget the '*' it will error with a complaint that entry is not
a structure type. Then I could make changes like this:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1244d2c5c384..55f1bdab4ffa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -587,19 +587,19 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 
 	trace_seq_printf(s, "\tfield: local_t commit;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
+			 (unsigned int)struct_offset(field, commit),
 			 (unsigned int)sizeof(field.commit),
 			 (unsigned int)is_signed_type(long));
 
 	trace_seq_printf(s, "\tfield: int overwrite;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), commit),
+			 (unsigned int)struct_offset(field, commit),
 			 1,
 			 (unsigned int)is_signed_type(long));
 
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-			 (unsigned int)offsetof(typeof(field), data),
+			 (unsigned int)struct_offset(field, data),
 			 (unsigned int)buffer->subbuf_size,
 			 (unsigned int)is_signed_type(char));
 
I would have a lot more places I can make this update then if
struct_offset() took a pointer instead of the struct itself. As adding
a '*' isn't ugly I think I like this way better.

What are your thoughts?

-- Steve
