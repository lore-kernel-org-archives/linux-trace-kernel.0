Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795016706;
	b=VGk/CoNrpI3Q0pxmt4w41nFIDhgz6nLuYcUSacBEcZrIIXqeMmfips25cJ8MbhK49Qpa
	 6cVPeK/778TGuYHIe97nU3/WAQj5Ncu9R39jK6z3e27/VoeAEPakJS9igCsPQ8WC17cWP
	 TqhTdgDE2xXweul0YBvlSsmGE1gAOm+MG/jilumIcCH/ZfAm4MbOX4GOJSYLgScLngRsW
	 dWGS/8sk1D4/v8wiGu7Piko3HiQPUQWuXGCE5WBde8ajgJwgZ8wd0Uv37nX5B+eeccP+k
	 fwGE2sa1AFOuCrmsR4PlOvimjnooKskLY509Dd/VRBRZ2i++iY8KbItoKUzy2EcsG1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016706;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lD8odh8aF3cXYF3pgON8co8fFrP86LksfskYjN4caBE=;
	b=B39N+eUbGwLAJRfZ5fgXuHn6lJDNAGoNVIoqmwqU8zzOeqVHrX1dhX+eu39UEx1C3fMR
	 StzwCQJ8cFQNnlKfW5YHOOVnr1kjNjOENGj7awPYcE5rubmc1yhNLwT5fravmcPJeaRWP
	 3zx7FwlZR1rmmG0hAsI+iIjJKFVtgFVtN9sJSxE4HpsdD24tnyXGrEHdD3Bn/GA6Jsnp2
	 dlaLbWRVfgyjs7pf5BqjUKJiTCIof8z9UwcdfxnIRwsS0MMzF4EHO8Fgy0BqV3uJzRjEo
	 aWQT9awCUsjiVCuY/xm8v17+p4y38E06x2z7JkjWAOV5tHEF+YIu5UM8qIJbR9TMVHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Li7Qr2PU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.10.56
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azolkn19012056.outbound.protection.outlook.com [52.103.10.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B44606A331;
	Wed, 18 Nov 2026 15:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B44606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=Li7Qr2PU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHtfiFleFkiPAGgbvNLhQDzI5aja9BNE4iVFqml99PuVdoTHerUGjdHRoyCa91/bQnFLNFeTGOJif+BOpj90CMpud1sEc4PjS2xOI2aHfMpfRnyJ4c/EH6y0k40pWnNESXJjERgOHUKoy9N1Lm1x8U/2avNiZW4LzlMZNiT2CjOZattvu4ClwxGLrPlWWMNQjJZMD56NXeFZHVi/9Dnw+uThFshBcwcBqxf20/m5FqRh2bz/n7jaaIYsineARMarAXOrVCCmW6/JPwivRXMuIz1mea8S8QTi0EkI8VAyepZr09Wguv4o4UvMkwUUSReqvQDMgbqXCFrFqfwNTIEIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lD8odh8aF3cXYF3pgON8co8fFrP86LksfskYjN4caBE=;
 b=bJ0ebI1yOtVo0dS2O7zgbMPbmjy+K4Dc9+MdUemKyyIjdBhzikkKAKqfGVAVsKN/KHZ3a1qs3fPiJTzjzt2voJNhqj0wQgiGID11sBqiJPLX7dbmLkPtYM/PvyhaSktJGmqIxk3/X779HblFWWeb2fJRrmASizMyAXfUTNlytQS4Y5UEP+13tFl3QzYvbR/F3eAhalx7mEAJELJSbvUgV8GnUkpU2j+2Y/8c+JG0/sHDe7oOaYRFy7JXz3p1k+OqW3+h8uqcyNJSAlNWFQLLZjZDlbNzTczpAfLFbAGID+QmME/TtiVTwyZSFH9cEh/JMyf6kz8GA2cO93Ic68zWdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD8odh8aF3cXYF3pgON8co8fFrP86LksfskYjN4caBE=;
 b=Li7Qr2PUe9vyLHWao+K35LY6KDMyR/uI5B+iCBLMNlAoT7Yf8wRll8LIs2lyXF6UW8yELaLIZmgpHUgF92qX/LWeC+XUzWWYgaGka9V9b2opkN9rivQ3cxxzIDFNpZOVT1vIjKM73JC2f+aEi/dY+nqxunKt1yRv+Mk6WtJYvCVRfSI1owEjd9bLrkxoUg56QssEZifIIFLIDdF7Qij4CW0LJKvNeWjxGQ7xal33eLdez+TCaNU6vsfKyZ16YSx5mplj1fh6n3RwCdBpcIAYxE9PLvQmyWui4pKdWmkDcEnd+p2beCrAUsBUTPSH+5+G9ilKLUFeEJhAnvdm3nME4w==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by DS6PR02MB673688.namprd02.prod.outlook.com (2603:10b6:8:4a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:45:04 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 15:45:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, David Lechner
	<dlechner@baylibre.com>, Armin Wolf <W_Armin@gmx.de>, Thierry Reding
	<thierry.reding@kernel.org>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Karl Mehltretter <kmehltretter@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, Dapeng Mi <dapeng1.mi@linux.intel.com>, Marco Elver
	<elver@google.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, Jeff Layton
	<jlayton@kernel.org>, Bradley Morgan <brads@mainlining.org>, Andrew Morton
	<akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Pnina Feder
	<pnina.feder@mobileye.com>, Mete Durlu <meted@linux.ibm.com>, Aaron Tomlin
	<atomlin@atomlin.com>, Rio <rioo.tsukatsukii@gmail.com>, Feng Tang
	<feng.tang@linux.alibaba.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH] driver core: Disable driver overriding by default
Thread-Topic: [PATCH] driver core: Disable driver overriding by default
Thread-Index: AQHEXwvVVha5onTuKtkCiJmDQ1XVv7dld0xQgAArsQCAAIZ2sA==
Date: Wed, 18 Nov 2026 15:45:03 +0000
Message-ID:
 <MN2PR02MB68630EC3F041DCF581083594D47A2@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261116110853.3418077-2-u.kleine-koenig@baylibre.com>
 <MN2PR02MB6863F6E744D2651D2520A238D47A2@MN2PR02MB6863.namprd02.prod.outlook.com>
 <av1UwuDq9JJkEYkN@monoceros>
In-Reply-To: <av1UwuDq9JJkEYkN@monoceros>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|DS6PR02MB673688:EE_
x-ms-office365-filtering-correlation-id: e75a5f39-f703-41f6-e376-08df458ae972
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUXBahuwteIkQeW30lJPuxOJYKhcnIzaA/RgPdtqr6HAWINzU+dtEffFuStHupksY6q+6NFU1R6zuiYmNqGPT/uMEtH1W0+6ZLKBDfbJhPHY+yx05E0XriIPl1Zg48OVSbvjuh8zs2TJZc4Sx3wgFSQQP8tcTEimM/YeBt2SsR3/RH2ojqS583RBbw5hwrYBcCI70vvcpdlMpkC0Eh0u0l8Qig3piI9xawMQt60AuoNRAWFzVMiAiivtjfal2mOUsCja2hfrRVpDHM9ne9eLJ0pRSQGfDTb6/YV0QU3zpd1EAvbiTmfzxtN2ieHomE22Vuhqo7GxXuAOVkDDZJ3ZLUmahMD6PW4YOHnRks911xmV7SVZvb7L+x8s98hpSry4aKAWpGlhkvB749qwgw6nl9/CyGT0ebGyM8+yvwZZszVGOxXUxqoBu4dlfdZUlk6HIrgpfWqrrdpNAxebdHFvTr4/hEhByntbqIPTVuqLxAKq40o7GVYfGeWTkE3+VnBbma5CkrNIb7zwPNsIF5ve6VnmHSVDpKLsUM7xqauKYYiHLFzp8gXxDPJQtQVXqNrOf71jjpa/AEKuj7Z+GTO/sNRWWFVAgCpYN2Pr+hguB5xFika3jRzMciEDW7T8k2G0+1lUJQbl4gHTUYi/NzsNBMx/eOZ6BhPoq5GvSuaBkWgwi83wq9YJsfyYF1rbULTz2QajxhJfXvroX0UW5oEHBBLRBOeTmnzSYrRKqTWSJsOrVba6ztMHy9stZATa+46Ujg=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|12121999013|13091999003|24021099003|37011999003|8060799015|51005399006|8062599012|55001999006|31061999003|19110799012|25010399006|40105399003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0l/+6iidOQrFwAMfgjT8Dwr9GQz9w2RFJRh58KVRnw4nbwcw80b2EBu5Z3?=
 =?iso-8859-1?Q?ixqWOmspPDI7EPv6ZgNlnLjaTEmGuriFkHJI+5TTVp4UDNgVs87Edi1aWC?=
 =?iso-8859-1?Q?9LDoaBkBBNnGI/N70tihMsIjWcFv2LEcaG+3edIVCdYZhqJuS9Lcb2FPIn?=
 =?iso-8859-1?Q?goZ0hk7xp9ve2rtHe6CAK/1cH4Lalva+Guj9BN4D4T8gWytuTG0g9ktIub?=
 =?iso-8859-1?Q?6dEmxmAg3PAKb3k6f5F9ZHNovdM71ecF7ck74sMgNRuo/MWhZfO/QoEfUZ?=
 =?iso-8859-1?Q?utegPjKs07706yOHplo33KoOGaUVsAn3UK0y6/k101zU6WfV4w2eBQzcl4?=
 =?iso-8859-1?Q?S1Oc9MG4ZTzKYGYu/Ap63TmoBJOk525IghwjTCgR7e+51EaJIpBmA+Uvs3?=
 =?iso-8859-1?Q?/sHuBYGz8tP56FAH5QqRB3RyzFuYT4cizn+5EosusvAPh6yt4qtwSg4OMs?=
 =?iso-8859-1?Q?RLWOOT4gW5kOzjvm4paf15Lgtxq2Vghp9nmZS1DkJLMt0X4dGbWKEywlPk?=
 =?iso-8859-1?Q?f+eJVaUmf0lxn9bwPXBO0ocxo/CKB2Q9dEbzmLOZhihd7aGEEo10HtMMPC?=
 =?iso-8859-1?Q?dz2TS8azxmXB6VBo59yq8XHBYCMOYb/sBiSWKSsj2fJs8UKEzJBR1Yl9ta?=
 =?iso-8859-1?Q?ITVrS8fUODunnk8rD36HzFQrQ8WerKV/ZOUJwPmQZFvDNs95knhadWnhE8?=
 =?iso-8859-1?Q?McwcY+Djv1cF+LFwURW3HHxovQqs35MBp+K3MP1CfAQnlmI0Q/maomNv8z?=
 =?iso-8859-1?Q?ocWsDI1Ztj4CheJ9NO2TDJeEe5RKGCCwuVdUm2OiBOH5aJXvPWJZGop9Hj?=
 =?iso-8859-1?Q?gsL8keP9ew8EowSiMBo1Le9MT8y2ICm+bfp3u7gesloXoznk1z2Lkr75CJ?=
 =?iso-8859-1?Q?z6xyqhE1/2NJXRE1r+Iu5ksSXUYtEeLBJxmmIc8QvHleriWPc6f7LVmZXd?=
 =?iso-8859-1?Q?3hvqT6a2F8EGts9zNnYGS35joBmAZLJlJ6QNDMsgLDBYzFlgvZOxHqyUQc?=
 =?iso-8859-1?Q?xbik3gf6SSXmDsTvIlQHT/WGvorruimmkv16VTalT2BDCsAJ/1tgrqh+vs?=
 =?iso-8859-1?Q?ZlW8i0m6R4W2zY2kvKMDyWsY/B9BUvZnC/BEbOM22IbA?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DPwDQ4GZsNAvN77v/kDbg5yj7fev8mKOWBFMkFTztlRjG8mcr61AB5pE37?=
 =?iso-8859-1?Q?jMaB/eactY2TmTf5e2nVdvFrbhEsptg6vkKKrsojY4CLDPQlQEF91OlK5I?=
 =?iso-8859-1?Q?9qasbKt5LNvMS/CeYur4D4Lix0cGIaKh62BzOdXcKy0/KE14T6CM1M5rIP?=
 =?iso-8859-1?Q?2g6NqNNcNKuxPP+fSynDEWi4lxJHa55Np4ClnVinHQxxHTjEZki1jZhMzJ?=
 =?iso-8859-1?Q?V38aXyxj2xWrPeRuQPdU8ahByL9OBf17+EQ+OAr0p6Wshkm3SDH2Tw+q9n?=
 =?iso-8859-1?Q?Zciqqd/P7SrW8xB4FwdHlEVMXmVlSucHP/ib+pgLKLBtQq+UtioHFJ5O3S?=
 =?iso-8859-1?Q?1fyeoWjJnV9nHC2K00pPqQSHqVcerSIWTEpIpJonXnSF7HlIh7FBnassgs?=
 =?iso-8859-1?Q?4cc+TU4l9hcLuokUAm/MrnNYB6MXGpHvW5JAqWtWV4iFLaFvomzC7CTwS6?=
 =?iso-8859-1?Q?g0xIAEp47pUDe3VMQS2xZPywWAAJLUEXRHSaSIgKBu7ty+u6tWU8yn63xw?=
 =?iso-8859-1?Q?McR+DtD6CZgeUm6L/u3d0HZYz9P59pvaXUH0nCl4mlW0oVGt9LcLCSxfaS?=
 =?iso-8859-1?Q?MqA3xRki1n43nNNzi2pagFmfmPrA9xf3RFoHJxd20FLbIz2pyWre3cOGIn?=
 =?iso-8859-1?Q?K5/8CzmF+jNzauWawAHdG5tlpFog5x94cRmZZzAEk5wVmbeb9su6TbUFKb?=
 =?iso-8859-1?Q?ivKpOdsBmTuRFX7OsUyA2vYjphN/VItcE82sZYEXIzo2o7UqsvLo1/OvBa?=
 =?iso-8859-1?Q?FSQ8G+JuzfFuL7FOCWrE08gr/mDfvB403QdBkJLHDQsYh1ZO2KF7PRtchq?=
 =?iso-8859-1?Q?XNoJ4Pff5m8UWQWiTJci5Nc+IafVN75zv2a2NzzU8OF6WUk7/+NbOJ1Gl+?=
 =?iso-8859-1?Q?Sbgz/8/nqc/MfdhieY6H84+WNiNxjmMj169wAIOUFm0WVVZOKlqJ+PcNIe?=
 =?iso-8859-1?Q?EmpwLWEtxEH28ofuz5FyV14BSKisM+7bpXkZiJ40kovTBsJ0V8Sihe+LCq?=
 =?iso-8859-1?Q?Bi99nomli3RwdwrpVxoK1pmo6G/cOnDewNrBoByNgfFB3z/s8MVF/d36fY?=
 =?iso-8859-1?Q?dVBnEqh3R1C1L2X/x48iVfJ8A9/GTjpAWwp+hBhg5QyJTK6gbPoAIwoVbi?=
 =?iso-8859-1?Q?LheBuDI/CZ+lIFwpgz5FDMRPfsODGM6ei2Fg7oFyzYUTnDjULsvyKyOhwE?=
 =?iso-8859-1?Q?ETfN7UXt2/TH29mmJEGztM+sS5C8RI46d14vhNOI3eLh+XKc1dNjcEUO/E?=
 =?iso-8859-1?Q?dVLr6APzJHEACFl1zjD+FjIb9gVJTy/n7H0rrOu4cEYqaq/H5rF1Q7doG9?=
 =?iso-8859-1?Q?3WvO4AELZ45uoakYKqAthliz20M1c2xizEy7tDLgpLXX87dYZ/b5AUqJ1j?=
 =?iso-8859-1?Q?s4U6YeqU61rsIDP6gaLfQqCJa6a8MwHq1JFzNHljKY3GnpC6QmUsk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e75a5f39-f703-41f6-e376-08df458ae972
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 15:45:03.3768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR02MB673688

From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> Sent: Tuesday, Nove=
mber 17, 2026 11:44 PM
>=20
> On Wed, Nov 18, 2026 at 05:51:29AM +0000, Michael Kelley wrote:
> > From: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com> Sent: Monday, N=
ovember 16, 2026 3:09 AM

[snip]

> > > +/**
> > > + * device_match_driver_override() - Match a driver against the devic=
e's driver_override.
> > > + * @dev: device to check
> > > + * @drv: driver to match against
> > > + *
> > > + * Returns > 0 if a driver override is set and matches the given dri=
ver, 0 if a
> > > + * driver override is set but does not match, or < 0 if a driver ove=
rride is not
> > > + * set at all.
> >
> > Additionally, returns < 0 if a matching override exists but is disallow=
ed.
>=20
> Yeah, that comment is just taken unmodified from the old location of
> device_match_driver_override(). Indeed needs adaption.
>=20
> > > + */
> > > +int device_match_driver_override(struct device *dev,
> > > +				 const struct device_driver *drv)
> > > +{
> > > +	guard(spinlock)(&dev->driver_override.lock);
> > > +	if (dev->driver_override.name) {
> > > +		int ret =3D !strcmp(dev->driver_override.name, drv->name);
> > > +
> > > +		if (ret > 0 && !drv->support_driver_override) {
> >
> > Using "ret > 0" seems a bit odd since the value is essentially Boolean.
> > Suggest using just "ret".
>=20
> ok
>=20
> > > +			if (allow_driver_override) {
> > > +				add_taint_module(drv->owner,
> > > +						 TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
> > > +			} else {
> > > +				/*
> > > +				 * If you hit this warning and you need to
> > > +				 * quickly workaround this check, boot with
> > > +				 * allow_driver_override=3D1 on the kernel
> > > +				 * commandline. The right fix is to set the
> > > +				 * driver's .support_driver_override property.
> > > +				 */
> > > +				dev_warn(dev, "Suppressed driver override binding to %s.\n", drv=
->name);
> >
> > Maybe "Disallowed" instead of "Suppressed" in the message? Even better,
> > could the name of the device be provided? For example,
> >
> > "Disallowed bind of driver %s to device %s using driver override"
>=20
> dev_warn() emits the device name.

Oh, right. Ignore my comment about the device name. I just tried it
with a Hyper-V VMBus synthetic device, and here's the output, which
is fine:

[   80.105203] vmbus 0f749bd1-5637-4279-91f1-bde768dd030f: Suppressed drive=
r override binding to uio_hv_generic.

VMBus device names are full GUIDs, which isn't super handy, but it
is what it is. :-(

Michael
