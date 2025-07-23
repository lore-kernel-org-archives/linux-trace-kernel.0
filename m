Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060C2258CD8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305312; cv=none; b=QeuDVO4c7RWVfCKtEbe2WWkXfR0xzdgHX6wMTMbI+oIizXdGQGvXPgMmxhu+fvpOhfVrqrKJahuGO+9jDmzPUiGZRed5nlST2XWWzZnYWiHP1j5o/q+XyJugbZaRzEWTmVPffT2JylPq6q9v2GZjhONCuNk6gAngUAS1rKRjGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305312; c=relaxed/simple;
	bh=qbkCdF7EWwl/tqL5TKoBNdBvNskXvLKwwBDNfbuDA+k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nlWycWac7cnbvdXC+ex+CDJhS1Q7K+hkJv9QI9t8s7jOuIf48O18jc7qJxnXck8FaBb21Q/hlKjwHPr83RvzseApiwjwljbNJBl+6uNULlXxrNDJ9wQ1caGJUDpo/XCTJwYScV3TTQlJyXT7VYkqixHrczF4mKWoq6t8J2dkz5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xZHfY5r+; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xZHfY5r+"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753305308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K9I+CLZgNY4gnwsc75t+pkIuW17N0SFWdzhX6a32934=;
	b=xZHfY5r+QbNzSQe7zq8+lBpixZY+b/xtIOYktc8ga1VO1k9l0RZmK1KDuKLsE4LdX2LdzN
	eA5XyIhCPWrvgudpuWsDjoGrtxI8rcivshs/RwKGTMTZcAmUjttFSIjlckEbcdS/s8t00t
	jnOaGjvoPkrIi4jvitskDhMpSD80edM=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy() with
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250723143625.79ab2c16@batman.local.home>
Date: Wed, 23 Jul 2025 14:15:02 -0700
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Guillaume Nault <gnault@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE36F453-DEAE-432C-9CDA-0D2DA875CDA2@linux.dev>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
 <20250714123825.6f0485c9@batman.local.home>
 <F998F71D-1244-4154-BC5F-19201C23BDBE@linux.dev>
 <20250723143625.79ab2c16@batman.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Migadu-Flow: FLOW_OUT

On 23. Jul 2025, at 11:36, Steven Rostedt wrote:
> On Wed, 23 Jul 2025 10:46:12 -0700 Thorsten Blum wrote:
>=20
>> Your commit fca8300f68fe3 changed it from __dynamic_array() to =
__array()
>> and __string() seems to be just a special version of =
__dynamic_array()
>> with a length of -1.
>>=20
>> In the commit description you wrote: "Since the size of the name is =
at
>> most 16 bytes (defined by IFNAMSIZ), it is not worth spending the =
effort
>> to determine the size of the string."
>=20
> So the original had:
>=20
> 	__dynamic_array(char,  name,   IFNAMSIZ )
>=20
> Which is not dynamic at all. A dynamic_array (like __string) saves the
> size in meta data within the event. So basically the above is wasting
> bytes to save a fixed size. If you are going to use a dynamic array,
> might as well make it dynamic!
>=20
> I was doing various clean ups back then so I didn't look too deeply
> into this event when I made that change. I just saw the obvious waste
> of space in the ring buffer.
>=20
> Just to explain it in more detail. A dynamic_array has in the ring =
buffer:
>=20
> 	short offset;
> 	short len;
> 	[..]
> 	char  name[len];
>=20
> That is, 4 bytes are used to know the size of the array and where in
> the event it is located. Thus the __dynamic_array() usage basically =
had:
>=20
> 	short offset;
> 	short len =3D IFNAMSIZ;
> 	[..]
> 	char name[IFNAMSIZ];
>=20
> Why have the offset and length? with just __array(char, name, =
IFNAMSIZ}
> it would be just:
>=20
> 	char name[IFNAMSIZ];
>=20
> See why I changed it?
>=20
> Now, the change I'm suggesting now would make the __string() be =
dynamic!
>=20
> 	short offset;
> 	short len =3D strlen(res->nh && res->nh->fib_nh_dev ? =
res->nh->fib_nh_dev->name : "-") + 1;
> 	[..]
> 	char name[len];
>=20
> As IFNAMSIZ is 16, and the above adds 4 bytes to the name, if the name
> is less than 7 bytes or less, you save memory on the ring buffer.
>=20
> 	2 bytes: offset
> 	2 bytes: len;
> 	7 bytes + '\0'
>=20
> total: 12 bytes
>=20
> Note, if there's only one dynamic value, it is always at least 4 bytes =
aligned.

Thanks for the detailed explanation.

I think the better change would be this then:

diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
index 8d22b2e98d48..3f95df1fd155 100644
--- a/include/trace/events/fib6.h
+++ b/include/trace/events/fib6.h
@@ -32,8 +32,9 @@ TRACE_EVENT(fib6_table_lookup,
		__field(        u16,	dport		)
		__field(        u8,	proto		)
		__field(        u8,	rt_type		)
-		__array(		char,	name,	IFNAMSIZ )
-		__array(		__u8,	gw,	16	 )
+		__string(	name,	res->nh && res->nh->fib_nh_dev ?
+					res->nh->fib_nh_dev->name : "-"	=
)
+		__array(	__u8,	gw,	16	)
	),

	TP_fast_assign(
@@ -64,11 +65,8 @@ TRACE_EVENT(fib6_table_lookup,
			__entry->dport =3D 0;
		}

-		if (res->nh && res->nh->fib_nh_dev) {
-			strscpy(__entry->name, =
res->nh->fib_nh_dev->name, IFNAMSIZ);
-		} else {
-			strcpy(__entry->name, "-");
-		}
+		__assign_str(name);
+
		if (res->f6i =3D=3D net->ipv6.fib6_null_entry) {
			in6 =3D (struct in6_addr *)__entry->gw;
			*in6 =3D in6addr_any;
@@ -82,7 +80,7 @@ TRACE_EVENT(fib6_table_lookup,
		  __entry->tb_id, __entry->oif, __entry->iif, =
__entry->proto,
		  __entry->src, __entry->sport, __entry->dst, =
__entry->dport,
		  __entry->flowlabel, __entry->tos, __entry->scope,
-		  __entry->flags, __entry->name, __entry->gw, =
__entry->err)
+		  __entry->flags, __get_str(name), __entry->gw, =
__entry->err)
);

#endif /* _TRACE_FIB6_H */


I'll submit a v2 if you agree that this is correct.

Thanks,
Thorsten

