Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD862D7DDD;
	Fri, 19 Dec 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766136680; cv=none; b=LPhtMF5j9PX5gvCVsP5MdUydDXysSlJC6rQHyudt44m9P8EOhvTRW6FXzvcW2mlKUlitnR6wQxwoFYK47E/WcXPeT9xmS6sHVJSwrxX49XxjI+M66ZoxMH00DVcj8u5Fuzj69S3CeZ0oxaElCTJG+GFoQLfkZeMo3POyCRrB8xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766136680; c=relaxed/simple;
	bh=JDYyYGh8RrQI+zVY9L46NOe+/hWd6ylKrEcBti0g6qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZpK4ChlZIeES2f2ls53c5hOVuqv9LCZk6oKNWjld2hHiX9QyjUWVSuTvr25i2S37zI0pU0pnk6lbTA6xVQxEA7fECp5Do0zk8LHyM8HA8o6tAbjyheJ9GJ79zCKxBplxl2dMI0r8pKsLf22IFjg1z0ceSXknnTHet6LYNE8FWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvcBAeCu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvcBAeCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C49C4CEF1;
	Fri, 19 Dec 2025 09:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766136679;
	bh=JDYyYGh8RrQI+zVY9L46NOe+/hWd6ylKrEcBti0g6qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SvcBAeCu/Pdh7bz9GUGnJaSUHchFxGcvlI53HUKKzdzPql2UPl+smqieCqxW1wsQZ
	 EuoSKZEsntAzSe7zk6TKtg6GbVQJc+dU4H5Lq7/CRLTB0J7l2sP9cJQn0HJliWUu6B
	 z/Zc64Ldf8XVFX+m5hUYl5sEYIXrETQG/TxcJeHkijpPLPwiHDjRyLOPTOORnsv/64
	 cG6ZES1auagKZSszkJHI/LpAOHg6S0LU3FokQuuGl3jvEOGufr1Dwy8faUAoP3z8Tc
	 ZKAd1OAGMCgQ8lofMQAk7vNtl10f6FWCCOuhf45N99nAuDYF6mxrcTKNE4tipo8/ES
	 1VVHQZMet/rHQ==
Date: Fri, 19 Dec 2025 09:31:10 +0000
From: Mark Brown <broonie@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH v10 2/3] mm: Fix OOM killer inaccuracy on large many-core
 systems
Message-ID: <2a772584-2269-4008-809a-6123e226ebe3@sirena.org.uk>
References: <20251213185608.3418096-1-mathieu.desnoyers@efficios.com>
 <20251213185608.3418096-3-mathieu.desnoyers@efficios.com>
 <c8acf650-ef96-4449-ba85-557dedba0ffc@sirena.org.uk>
 <72ad1fed-574e-4850-beac-91626e5aaa0e@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nB8gAt2CMqOecX2t"
Content-Disposition: inline
In-Reply-To: <72ad1fed-574e-4850-beac-91626e5aaa0e@efficios.com>
X-Cookie: Save gas, don't eat beans.


--nB8gAt2CMqOecX2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18, 2025 at 05:18:04PM -0500, Mathieu Desnoyers wrote:
> On 2025-12-18 13:00, Mark Brown wrote:

> An ugly work-around that may work (and then we can improve on this),
> at the end of mm/init-mm.c:init_mm (completely untested):

>        .cpu_bitmap     = { [0 ... ((3*BITS_TO_LONGS(NR_CPUS))-1 + ((69905 * NR_MM_COUNTERS * 64) / BYTES_PER_LONG))] = 0UL },

That doesn't seem to fix the FVP unfortunately (BYTES_PER_LONG doesn't
exist, but even just deleting the division entirely fails in the same
way).

--nB8gAt2CMqOecX2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlFG10ACgkQJNaLcl1U
h9DefQf+JvhAM2zVW8yicN4Cg9fpYL03mrmvjIMlhXaVtEKithjABrlXzEEnlEg+
+zjtAMmjdy6Rk/9g54g3fYkcixYEqyyUsVAW9NMMWs+zzvVRaDvol9QqVeuaSn4g
6IpUfrPOtlWq6PKKMhcCiLmiK2Rh+83F0NJYtr2/NpDNmg2pelTUgURJa3+6FRsv
LxhkCeEDvayR0U6J4PT3iDQrRACrqkLZ+tXAArOS/jQ9BPC4yQhXfCISptkXadbI
8fnQKlQUlAPh8OJN2lqiqUZWJ0z+OTl4/s5MKoRqB6sEh6bI6vftmyZCcFF7rjlW
w2PeciwdUO+nJz/TS73YbVRA72dd9Q==
=7twn
-----END PGP SIGNATURE-----

--nB8gAt2CMqOecX2t--
